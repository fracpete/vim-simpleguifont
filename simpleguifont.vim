" Vim plugin for quickly changing GUI font size.
"
" Maintainer: Peter Reutemann <fracpete at gmail dot com>
"
" Description:
" This plugin is based on Alexander Anderson's guifont++ plugin:
" https://www.vim.org/scripts/script.php?script_id=593
"
" This plugin defines key mappings to quickly make the GUI font larger or
" smaller. The default mappings are "+" to make the font larger by 1 point
" and "-" to make the font smaller by 1 point. The original font size can
" be restored with "=" key at any time. The mappings are user-configurable
" (see the installation section below).
"
" This plugin sets the 'guifont' option using the following format:
" guifont = <fontname> <fontsize>
"
" Compared to the original guifont++ plugin, this plugin requires you to
" define the name of the font that you want to use. For example, when 
" using the 'Hack' (https://sourcefoundry.org/hack/) font, you need to
" set the following in your .vimrc file:
"   let simpleguifont_fontname="Hack"
"
" Installation:
" Simply copy this plugin into your plugin directory. (See 'plugin' in the
" Vim User Manual.) Additionally, you may choose to override one of the
" following global variables, which are used by this plugin, in your vimrc
" file:
"
"  - simpleguifont_size_increment         (default: 1)
"       The number of points by which to make the font size smaller or
"       larger.
"  - simpleguifont_smaller_font_map       (default: "-")
"       LHS of the key mapping to make the font size smaller.
"  - simpleguifont_larger_font_map        (default: "+")
"       LHS of the key mapping to make the font size larger.
"  - simpleguifont_original_font_map      (default: "=")
"       LHS of the key mapping to restore the original font size.
"
" For example, you could have something like this in your vimrc file:
"   let simpleguifont_size_increment=2
"   let simpleguifont_smaller_font_map="<F6>"
"   let simpleguifont_larger_font_map="<S-F6>"
"   let simpleguifont_original_font_map="<C-F6>"
"   let simpleguifont_fontname="Hack"
"
" Version: 0.0.1

if exists("loaded_simpleguifont") || !exists("&guifont")
    finish
endif
let loaded_simpleguifont = 1

let s:simpleguifont_size_increment = 1
let s:simpleguifont_smaller_font_map = "-"
let s:simpleguifont_larger_font_map = "+"
let s:simpleguifont_original_font_map = "="
let s:simpleguifont_fontname = "Hack"

if exists("g:simpleguifont_size_increment")
    let s:simpleguifont_size_increment = g:simpleguifont_size_increment
endif
if exists("g:simpleguifont_smaller_font_map")
    let s:simpleguifont_smaller_font_map = g:simpleguifont_smaller_font_map
endif
if exists("g:simpleguifont_larger_font_map")
    let s:simpleguifont_larger_font_map = g:simpleguifont_larger_font_map
endif
if exists("g:simpleguifont_original_font_map")
    let s:simpleguifont_original_font_map = g:simpleguifont_original_font_map
endif

let s:decimalpat = '[1-9][0-9]*'
let s:fontpat = '\(.* \)\(' . s:decimalpat . '\)$'

fun! s:GetFontSize()
    let sizealmost = matchstr(&guifont, s:fontpat)
    let size = matchstr(sizealmost, s:decimalpat . '$')
    if size == ""
        echoerr "Cannot match your 'guifont' to a known pattern"
    endif
    if !exists("s:originalFontSize")
        let s:originalFontSize = size
    endif
    return size
endfun

fun! s:SetFontSize(size)
    let guifont = substitute(&guifont, s:fontpat, s:simpleguifont_fontname . ' ' . a:size, "")
    let &guifont = guifont
endfun

fun! s:SetLargerFont()
    let size = s:GetFontSize()
    if size
        call s:SetFontSize(size + s:simpleguifont_size_increment)
    endif
endfun

fun! s:SetSmallerFont()
    let size = s:GetFontSize()
    if size && size > 1
        call s:SetFontSize(size - s:simpleguifont_size_increment)
    endif
endfun

fun! s:SetOriginalFont()
    if s:originalFontSize
        call s:SetFontSize(s:originalFontSize)
    else
        echoerr "Original font size is unknown"
    endif
endfun

let s:ms = "map <silent> "
exe s:ms . s:simpleguifont_smaller_font_map  . " :call <SID>SetSmallerFont()<CR>"
exe s:ms . s:simpleguifont_larger_font_map   . " :call <SID>SetLargerFont()<CR>"
exe s:ms . s:simpleguifont_original_font_map . " :call <SID>SetOriginalFont()<CR>"

