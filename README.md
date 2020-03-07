# vim-dict

Automatically add dictionary files to current buffer according to the filetype.

## Installation

```VimL
Plug 'skywind3000/vim-dict'
```

## Add additional dict folders

```VimL
let g:vim_dict_dict = [
    \ '~/.vim/dict',
    \ '~/.config/nvim/dict',
    \ ]
```

## File type override

```VimL
let g:vim_dict_config = {'html':'html,javascript,css', 'markdown':'text'}
```

## Disable certain types

```VimL
let g:vim_dict_config = {'text': ''}
```
