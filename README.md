# Medit (Macro Edit)
## Medit is a plugin for editing your macros
Ever work on a long macro and need to change something about it half way through? sure ya have.
This'll let you open up a nice window (either floating or split) where you can edit your macro. Neat huh?

## Demo
[![asciicast](https://asciinema.org/a/WUDWsmIkqH1LNhR6pENLSGLYo.svg)](https://asciinema.org/a/WUDWsmIkqH1LNhR6pENLSGLYo)

## Default Usage
open up the window with
```
  <Leader>q{macro register you care about}
```
Then when you're done editing, just hit `q` and it'll save the macro to the register you wanted, or hit `<esc>` to abort! Cool!

## Setup

MEdit should have default mappings out of the box, but you can set your own mappings if you want using `let g:medit_no_mappings = 1` and then `nmap {whatever you want} <Plug>MEdit`

### Coming Soon
- [ ] Preview for changes to lines in the buffer you called things from 
- [ ] Preserving your clipboard
