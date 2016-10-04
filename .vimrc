set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'taketwo/vim-ros'
Plugin 'scrooloose/nerdtree'
Plugin 'bkad/CamelCaseMotion'
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/nerdcommenter'

call vundle#end() "required
filetype plugin indent on
" Display options
set number
set smartindent
set expandtab
set shiftwidth=2
set tabstop=2
set textwidth=80
set t_Co=256
set showmatch
set comments=s1:/*,mb:\ *,elx:\ */
" Fix line width
"set colorcolumn=80

highlight ColorColumn ctermbg=blue guibg=blue
call matchadd('ColorColumn', '\%80v', 100)

" Escape from insert mode
inoremap jk <Esc>

" Color scheme
syntax enable
colorscheme desert
set background=dark
set encoding=utf8


" LateX

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
"
nnoremap <C-n> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" add closing brackets automatically
" inoremap { {<CR>}<Esc>kO

map .. <leader>c<SPACE>

" Allows to type :w!! if one forgot to use sudo to open file.
" (see http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work)
 
cmap w!! w !sudo tee > /dev/null %

" replace cout and endl by std::cout and std::endl
" cmap std!! :%s/[^\(std::\)]cout/ std::cout/gc

" Always equally distribute splitted windows.
autocmd VimResized * wincmd =

" insert a new line without entering insert mode
nmap <C-CR> O<Esc>j
nmap <CR> o<Esc>k
" code folding
set foldmethod=indent
nnoremap <space> za
vnoremap <space> zf
" camel case motion
call camelcasemotion#CreateMotionMappings('<leader>')
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e

" YouCompleteMe Stuff
let g:ycm_global_ycm_extra_conf = "/home/kiki/.vim/.ycm_extra_conf.py"
let g:ycm_semantic_triggers = {
            \    'roslaunch' : ['="','$(','/'],
            \'rosmsg,rossrv,rosaction' : ['re!^','/'],
            \}
" unset YouCompleteMe for latex files. DOESN't change anything!
let g:ycm_filetype_blacklist = {
      \'tex_flavor' : 1,
      \}
let g:ycm_filetype_specific_completion_to_disable = {
      \'tex_flavor' : 1,
      \}

let g:clang_format#detect_style_file = 1


" // comments
let g:NERDCustomDelimiters = {'c': { 'leftAlt': '/*', 'rightAlt': '*/', 'left': '//'}}

" spaces before comments
let g:NERDSpaceDelims=1
