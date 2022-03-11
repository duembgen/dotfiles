set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() 
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'chase/vim-ansible-yaml'
"Plugin 'kchmck/vim-coffee-script'
"Plugin 'vim-scripts/indentpython.vim' " python indentation
Plugin 'aperezdc/vim-template' " template files
"Plugin 'SirVer/ultisnips' " Engine for inserting code snippets
"Plugin 'honza/vim-snippets' " Code snippets
"Plugin 'tpope/vim-surround' " Surround with quotes, brackets, tags etc.
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
" Plugin 'google/vim-maktaba'
" Plugin 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
"Plugin 'google/vim-glaive'
Plugin 'vim-latex/vim-latex'
" Auto formatting with black
" Plugin 'psf/black'
Plugin 'pseewald/vim-anyfold'
" ...
" Auto complete
Plugin 'davidhalter/jedi-vim'
" Vundle plugin
Plugin 'dense-analysis/ale'
call vundle#end()

let g:email = 'frederike.duembgen@gmail.com'
let g:username = 'Frederike Duembgen'

filetype plugin indent on
syntax on
" Display options
"set number
set smartindent
set expandtab
set shiftwidth=2
set tabstop=2
"set textwidth=80
set t_Co=256
set showmatch
set comments=s1:/*,mb:\ *,elx:\ */
" Fix line width
"set colorcolumn=80

" highlight the max column width. 
"highlight ColorColumn ctermbg=blue guibg=blue
"call matchadd('ColorColumn', '\%80v', 100)

" Color scheme
syntax enable
colorscheme desert
set background=dark
set encoding=utf8

" nerdommenter
let g:NERDCustomDelimiters = {'c': { 'leftAlt': '/*', 'rightAlt': '*/', 'left': '//'}}
" spaces before comments
let g:NERDSpaceDelims=1

" paste toggle
set pastetoggle=<F2>

" ---------------------------------------------
" --------------- LATEX SHIT ------------------
" ---------------------------------------------

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" " The following changes the default filetype back to 'tex'
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf,bib,pdf'
let g:Tex_CompileRule_pdf='latexmk -pdf -dvi- -ps- -recorder'

" navigate windows 
nnoremap <C-n> <C-w>j 
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" enable/disable you complete me. 
nnoremap <C-a> :let g:ycm_auto_trigger=0<CR>               
nnoremap <C-b> :let g:ycm_auto_trigger=1<CR>           

" move cursor while in insert mode. 
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l



" change escape key
inoremap <F12> <ESC>
inoremap jk <ESC>
inoremap ii <ESC>


nnoremap <C-t> :tabn<cr>

" comment stuff
map .. <leader>c<SPACE>

" insert a new line without entering insert mode
nmap <C-o> o<ESC>k

" search replace selection.
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left><left>

" Allows to type :w!! if one forgot to use sudo to open file.
" (see http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work)
cmap w!! w !sudo tee > /dev/null %

" Always equally distribute splitted windows.
autocmd VimResized * wincmd =

" ---------------------------------------------
" --------------- TEMPLATE SHIT ---------------
" ---------------------------------------------

" Global templates directory
let g:templates_directory = '~/.vim/templates'

" Template filename prefix
let g:templates_global_name_prefix = ''

" No default templates
let g:template_no_builtin_template = 1

" ---------------------------------------------
" ------------- Black Formatting --------------
" ---------------------------------------------
" autocmd BufWritePre *.py execute ':Black'


" ---------------------------------------------
" ----------- Make backspace work -------------
" ---------------------------------------------
set backspace=indent,eol,start

" disable jedi cause it takes too long with pandas
let g:jedi#completions_enabled = 1


" ---------------------------------------------
" --------- Automatic spell check ------------
" ---------------------------------------------
" Ignore CamelCase words when spell checking
fun! IgnoreCamelCaseSpell()
   syn match CamelCase /\<[A-Z][a-z].\{-}\>/ contains=@NoSpell transparent
   syn cluster Spell add=CamelCase
endfun
autocmd BufRead,BufNewFile * :call IgnoreCamelCaseSpell()
syntax match texStatement '\\cref' nextgroup=texMyCommand
syntax region texMyCommand matchgroup=Delimiter start='{' end='}' contained contains=@NoSpell
set spelllang=en
set spellfile=$HOME/.vim/spell/en.utf-8.add
autocmd BufRead,BufNewFile *.tex setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell
" move to next word
nnoremap nw ]s
" add word word
nnoremap aw zg
" choose first suggestion
nnoremap cw 1z= 
" let g:tex_comment_nospell=1

" ---------------------------------------------
" ----------- Code folding ------ -------------
" ---------------------------------------------
autocmd Filetype *.py AnyFoldActivate
autocmd Filetype *.c AnyFoldActivate
autocmd Filetype *.cpp AnyFoldActivate
set foldlevel=99
" code folding
set foldmethod=indent
nnoremap <space> za
vnoremap <space> zf

let g:vimtex_syntax_nospell_commands = ['cref']
