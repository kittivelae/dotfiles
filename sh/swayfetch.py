import os

"""
    Rudimentary script to print sway (and maybe i3? idk) keybindings from config file.
    Not perfect.

    Assumptions:
    - location of config (namely ~/.config/sway/config)
    - keybindings are in the same file as the config.

    You will also need to place #parsestart and #parseend in the config file
    prior to using this script. Apart from that it should work quite well with
    the default config file, since mine is heavily based on it.
"""

def mod_key_to_str(mod_key):
    if mod_key == 'Mod1':
        return 'Alt'
    elif mod_key == 'Mod4':
        return 'Win'
    else:
        return mod_key

def get_vars():
    loc = f'{os.getenv("HOME")}/.config/sway/config'
    return_data = {}
    with open(loc, 'r') as f:
        for line in f:
            if line.startswith('set'):
                strs = line.split()
                if not len(strs) ==3 or not strs[1].startswith('$'):
                    continue
                return_data[strs[1]] = mod_key_to_str(strs[2]) if strs[1] == '$mod' else strs[2]
    return return_data

def main():
    _vars = get_vars()
    loc = f'{os.getenv("HOME")}/.config/sway/config'
    found_file_start = False
    printing_cmds = False
    printing_cmmts = False
    with open(loc, 'r') as f:
        for line in f:
            line = line.strip()
            if line == '#parseend':
                break
            if line == '#parsestart':
                found_file_start = True
            if line == '#parsestart' or not found_file_start:
                continue

            for key in _vars:
                line = line.replace(key, _vars[key])

            is_cmmt = line.startswith('#')
            is_cmd = line.startswith('bindsym')
            cond_newline = '\n' if (is_cmmt and printing_cmds) or (is_cmd and printing_cmmts) else ''

            if is_cmmt and len(line) > 1:
                print(cond_newline + line[1:].strip('#').strip() + cond_newline)
                if printing_cmds is False and printing_cmmts is False:
                    printing_cmmts = True
                printing_cmds = False
            elif is_cmd:
                printing_cmds = True
                printing_cmmts = False
                strs = line.split()
                print(f'{cond_newline}\t{strs[1]} - {" ".join(strs[2:])}')

    return 0

if __name__ == "__main__":
    main()
