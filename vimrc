set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() 
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'bkad/CamelCaseMotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'chase/vim-ansible-yaml'
Plugin 'kchmck/vim-coffee-script'
" Plugin 'scrooloose/syntastic' " syntax highlighting
" Plugin 'nvie/vim-flake8' " PEP 8 syntax highlighting
" Plugin 'tmhedberg/SimpylFold' " python code folding
Plugin 'vim-scripts/indentpython.vim' " python indentation
Plugin 'aperezdc/vim-template' " template files
Plugin 'SirVer/ultisnips' " Engine for inserting code snippets
Plugin 'honza/vim-snippets' " Code snippets
Plugin 'tpope/vim-surround' " Surround with quotes, brackets, tags etc.

" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plugin 'google/vim-glaive'
" ...
call vundle#end()

filetype plugin indent on
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

highlight ColorColumn ctermbg=blue guibg=blue
call matchadd('ColorColumn', '\%80v', 100)

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
"
nnoremap <C-n> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" add closing brackets automatically
" inoremap { {<CR>}<Esc>kO

" change escape key
inoremap jk <ESC>

map .. <leader>c<SPACE>

" Allows to type :w!! if one forgot to use sudo to open file.
" (see http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work)
 
cmap w!! w !sudo tee > /dev/null %

" Always equally distribute splitted windows.
autocmd VimResized * wincmd =

" insert a new line without entering insert mode
nmap <C-o> o<ESC>k

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
"let g:ycm_global_ycm_extra_conf = ~/ROS/stereo_ws/src/.ycm_extra_config.py"
" let g:ycm_global_ycm_extra_conf = "/home/kiki/.vim/.ycm_extra_conf.py"
"let g:ycm_semantic_triggers = {
"            \    'roslaunch' : ['="','$(','/'],
"            \'rosmsg,rossrv,rosaction' : ['re!^','/'],
"            \}
let g:ycm_python_binary_ath = '/usr/bin/python3'

" search replace selection.
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left><left>

" ---------------------------------------------
" --------------- TEMPLATE SHIT ---------------
" ---------------------------------------------

" Global templates directory
let g:templates_directory = '/home/kiki/.vim/templates'

" Template filename prefix
let g:templates_global_name_prefix = 'template'

" No default templates
let g:template_no_builtin_template = 1

let g:email = 'frederike.duembgen@gmail.com'
let g:username = 'Frederike Duembgen'

" ---------------------------------------------
" -------------- ULTISNIPS SHIT ---------------
" ---------------------------------------------

let g:UltiSnipsUsePythonVersion = 3 " vim is compiled with python3 (echo has('python3')
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger="<c-g>"
let g:UltiSnipsListSnippets="<c-h>"
let g:UltiSnipsSnippetDirectories = ['/home/kiki/.vim/UltiSnips', 'UltiSnips']

" ---------------------------------------------
" --------------- VIM CODEFMT -----------------
" ---------------------------------------------
" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  "autocmd FileType python AutoFormatBuffer yapf
augroup END
