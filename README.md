# vim-simpleguifont
Simple vim plugin for changing the font size of your GVim via keybindings.

This plugin is based on Alexander Anderson's guifont++ plugin:

https://www.vim.org/scripts/script.php?script_id=593

This plugin defines key mappings to quickly make the GUI font larger or
smaller. The default mappings are `+` to make the font larger by 1 point
and `-` to make the font smaller by 1 point. The original font size can
be restored with "=" key at any time. The mappings are user-configurable
(see the installation section below).

This plugin sets the `guifont` option using the following format:

```
guifont = <fontname> <fontsize>
```

Compared to the original guifont++ plugin, this plugin requires you to
define the name of the font that you want to use. For example, when 
using the 'Hack' (https://sourcefoundry.org/hack/) font, you need to
set the following in your `.vimrc` file:

```
let simpleguifont_fontname="Hack"
```

## Installation

Simply copy this plugin into your plugin directory. (See 'plugin' in the
Vim User Manual.) Additionally, you may choose to override one of the
following global variables, which are used by this plugin, in your vimrc
file:

* simpleguifont_size_increment (default: 1)

  The number of points by which to make the font size smaller or larger.

* simpleguifont_smaller_font_map (default: "-")

  LHS of the key mapping to make the font size smaller.

* simpleguifont_larger_font_map (default: "+")

  LHS of the key mapping to make the font size larger.

* simpleguifont_original_font_map (default: "=")

  LHS of the key mapping to restore the original font size.

For example, you could have something like this in your vimrc file:

```
let simpleguifont_size_increment=2
let simpleguifont_smaller_font_map="<F6>"
let simpleguifont_larger_font_map="<S-F6>"
let simpleguifont_original_font_map="<C-F6>"
let simpleguifont_fontname="Hack"
```

