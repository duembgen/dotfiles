" LaTeX filetype
"	  Language: LaTeX (ft=tex)
"	Maintainer: Srinath Avadhanula
"		 Email: srinath@fastmail.fm

if !exists('s:initLatexSuite')
	let s:initLatexSuite = 1
	exec 'so '.fnameescape(expand('<sfile>:p:h').'/latex-suite/main.vim')

	silent! do LatexSuite User LatexSuiteInitPost
endif

silent! do LatexSuite User LatexSuiteFileType

" Use <C-n> to scroll through labels with \ref{
set iskeyword+=:

" ------------- CUSTOM MACROS ----------------- 
" figure 
let g:Tex_Env_figure = "\\begin{figure}[<+location+>]\<CR>\\centering\<CR>\\includegraphics[<+size+>]{<+filename+>}\<CR>\\caption{<+caption+>}\<CR>\\label{fig:<+label+>}\<CR>\\end{figure}\<CR><++>" 
 
" subfigure 
call IMAP('ESF',"\\begin{subfigure}{<+subfigure width+>}\<CR>\\includegraphics[<+image size+>]{<+image file+>}\<CR>\\caption{<+caption+>}<++>\<CR>\\end{subfigure}\<CR><++>",'tex') 

call IMAP('EMB',"\\mathbf{<++>}",'tex')
	
