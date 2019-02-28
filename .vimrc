" pysnow530's vimrc file.
"
" Maintainer:   pysnow530 <pysnow530@163.com>
" Inittime:     Apr 5, 2015
"
" vim
" 1. place this file to ~/.vimrc
" 2. run curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" neovim
" 1. place this file to ~/.config/nvim/init.vim
" 2. curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" 3. vim or nvim, then :PlugInstall

" leaders
let mapleader = ","
let maplocalleader = '\'

" {{{ style preferences
syntax on
set history=50
set showcmd
set hlsearch
set incsearch
set guifont=Monaco:h14
set showmatch
set scrolloff=3
set nowrap
set foldtext=getline(v:foldstart)

set cursorline
if exists('+colorcolumn') | set colorcolumn=79 | endif
set nu
if exists('+rnu') | set rnu | endif

fun! StatusLineWrapper() abort
    if exists('*bufferline#refresh_status')
        return '%{bufferline#refresh_status()}' .
                    \ bufferline#get_status_string() . '%=%y %=%P '
    else
        return '%f %=%y %=%P '
    endif
endf

set statusline=%!StatusLineWrapper()
set laststatus=2

nnoremap <SPACE> za
" }}}

" {{{ edit preferences
set fileencodings=utf-8,ucs-bom,cp936,gb18030,big5,euc-jp,euc-kr,latin1
try
    set encoding=utf-8
catch //
endtry
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set sessionoptions+=unix,slash
set lazyredraw
set undofile

set mouse=a

set wildignore+=*.class,*.pyc

inoremap jk <ESC>
inoremap <c-u> <esc>vbUea
nnoremap <leader>b :b#<cr>
function! DeleteBufferOrCloseWindow() abort
    let bufcnt = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
    let wincnt = winnr('$')

    if wincnt == 1 && bufcnt > 1
        execute 'bdelete'
    else
        execute 'q'
    endif
endfunction
nnoremap <leader>q :call DeleteBufferOrCloseWindow()<cr>
nnoremap <leader>. :e ~/.vimrc<cr>
if isdirectory('.git') || isdirectory('../.git') || isdirectory('../../.git')
    set grepprg=git\ grep\ -n\ $*
else
    set grepprg=grep\ -n\ $*\ -r\ .\ --exclude\ '.*.swp'
endif
command! -nargs=+ NewGrep execute 'silent grep! <args>' | copen 10
nnoremap <leader>g :NewGrep <cword>
nnoremap <leader>w <c-w><c-w>
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <leader>k :q<cr>
nnoremap <leader><leader> q:
nnoremap <leader>j :w<cr>
inoremap <leader>j <esc>:w<cr>

function! ToggleWrap()
    if &wrap == 1
        set nowrap
    else
        set wrap
    endif
endfunction
nnoremap <leader>w :call ToggleWrap()<cr>
" }}}

" {{{ plugins
filetype off

call plug#begin()
Plug 'VundleVim/Vundle.vim'
Plug 'msanders/snipmate.vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'lvht/tagbar-markdown'
Plug 'pysnow530/snipmate-snippets'
Plug 'tomtom/tcomment_vim'
Plug 'christoomey/vim-sort-motion'
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'ap/vim-css-color'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'nvie/vim-flake8'
Plug 'cohama/lexima.vim'
Plug 'bling/vim-bufferline'
Plug 'udalov/kotlin-vim'
Plug 'pysnow530/rfc.vim'
Plug 'vim-scripts/argtextobj.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'pysnow530/nginx.vim'
Plug 'fatih/vim-go'
Plug 'justinmk/vim-sneak'
Plug 'rhysd/clever-f.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'wakatime/vim-wakatime'
Plug 'ledger/vim-ledger'
call plug#end()

" snipmate.vim
let g:snips_author = 'jianming.wu'

" emmet-vim
let g:user_emmet_leader_key = '<leader>e'

" nerdtree
let g:NERDTreeQuitOnOpen = 0
nmap <leader>n :NERDTreeToggle<cr>
let NERDTreeIgnore = ['\~$', '\.class$', '\.pyc$']

" tagbar
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
let g:tagbar_autofocus = 1
nmap <leader>t :TagbarToggle<cr>

" vim-colors-solarized
set background=light
colorscheme solarized

" vim-fugitive
nnoremap <leader>v :Gstatus<cr>

" vim-bufferline
let g:bufferline_echo = 0

" Shougo/neocomplete.vim
if v:version >= 703 && has('lua')
    let g:neocomplete#enable_at_startup = 1
endif

" kien/ctrlp.vim
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0

" Valloric/YouCompleteMe
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']

" }}}

" {{{ filetypes
filetype plugin indent on

" filetypes
nnoremap <localleader>t :exe 'e' tempname() . '.' . expand('%:e')<cr>

augroup filetype_shell
    autocmd!
    autocmd FileType sh nnoremap <buffer> <localleader>r :!sh %<cr>
    autocmd FileType sh vnoremap <buffer> <localleader>r :w !sh<cr>
    autocmd FileType sh nnoremap <buffer> <localleader>d :!sh -x %<cr>
augroup END

augroup filetype_php
    autocmd!
    autocmd FileType php nnoremap <buffer> <localleader>r :!php %<cr>
    autocmd FileType php vnoremap <buffer> <localleader>r :w !php<cr>
    command! -nargs=1 Phpdoc !open http://php.net/<args>
    autocmd FileType php setlocal keywordprg=:Phpdoc
augroup END

augroup filetype_c
    autocmd!
    autocmd FileType c nnoremap <buffer> <localleader>r :!gcc % && ./a.out<cr>
augroup END

augroup filetype_cpp
    autocmd!
    autocmd FileType cpp nnoremap <buffer> <localleader>r :!g++ % && ./a.out<cr>
augroup END

augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>r :!open %<cr>
    autocmd FileType html setlocal foldmethod=indent
    autocmd FileType htmldjango setlocal filetype=htmldjango.html
augroup END

augroup filetype_javascript
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <localleader>r :!node %<cr>
    autocmd FileType javascript vnoremap <buffer> <localleader>r :w !node<cr>
    autocmd FileType javascript nnoremap <buffer> <localleader>i :!node<cr>
    autocmd FileType javascript nnoremap <buffer> <localleader>c :!eslint --no-eslintrc %<cr>
augroup END

function! GetGitRootDir()
    let curr_path = '%:p:h'

    for i in range(10)
        if isdirectory(expand(curr_path) . '/.git')
            return expand(curr_path)
        endif

        let curr_path = curr_path . ':h'
    endfor

    return ''
endfunction

function! RunWithPython(exe_cmd_tmpl)
    let root_dir = GetGitRootDir()
    if (root_dir != '' && filereadable(root_dir . '/.env/bin/python'))
        let python_path = root_dir . '/.env/bin/python'
    elseif (root_dir != '' && filereadable(root_dir . '/.venv/bin/python'))
        let python_path = root_dir . '/.venv/bin/python'
    else
        let python_path = 'python'
    endif

    let exec_cmd = substitute(a:exe_cmd_tmpl, '{python_path}', python_path, '')
    exec exec_cmd
endfunction

augroup filetype_python
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>r :call RunWithPython('!{python_path} %')<cr>
    autocmd FileType python vnoremap <buffer> <localleader>r :call RunWithPython('w !{python_path}')<cr>
    autocmd FileType python nnoremap <buffer> <localleader>i :call RunWithPython('!{python_path}')<cr>
    autocmd FileType python nnoremap <buffer> <localleader>c :call flake8#Flake8()<cr>
augroup END

augroup filetype_ruby
    autocmd!
    autocmd FileType ruby nnoremap <buffer> <localleader>r :!ruby %<cr>
    autocmd FileType ruby vnoremap <buffer> <localleader>r :w !ruby<cr>
    autocmd FileType ruby nnoremap <buffer> <localleader>s :!irb<cr>
augroup END

augroup filetype_vim
    autocmd!
    autocmd BufWritePost vimrc,.vimrc so <afile>
    autocmd FileType vim nnoremap <buffer> <localleader>r :so %<cr>
    command! -nargs=1 Vimdoc help <args>
    autocmd FileType vim setlocal keywordprg=:Vimdoc
augroup END

augroup filetype_makefile
    autocmd!
    autocmd FileType make setlocal shiftwidth=8
    autocmd FileType make setlocal noexpandtab
    autocmd FileType make setlocal tabstop=8
augroup END

augroup filetype_lua
    autocmd!
    autocmd FileType lua nnoremap <buffer> <localleader>r :!lua %<cr>
    autocmd FileType lua vnoremap <buffer> <localleader>r :w !lua<cr>
    autocmd FileType lua nnoremap <buffer> <localleader>i :!lua<cr>
augroup END

augroup filetype_cs
    autocmd!
    autocmd FileType cs nnoremap <buffer> <localleader>b :!csc.exe /out:%:r.exe %<cr>
    autocmd FileType cs nnoremap <buffer> <localleader>r :!%:r.exe<cr>
augroup END

augroup filetype_scheme
    autocmd!
    autocmd FileType scheme nnoremap <buffer> <localleader>r :!mzscheme %<cr>
    autocmd FileType scheme vnoremap <buffer> <localleader>r :w !mzscheme<cr>
augroup END

augroup filetype_dot
    autocmd!
    autocmd FileType dot nnoremap <buffer> <localleader>r :!dot -Tpng % >%:r.png && open %:r.png<cr>
    autocmd FileType dot nnoremap <buffer> <localleader>b :!dot -Tpng % >%:r.png<cr>
augroup END

augroup filetype_coffee
    autocmd!
    autocmd FileType coffee nnoremap <buffer> <localleader>b :!coffee -c %<cr>
    autocmd FileType coffee nnoremap <buffer> <localleader>r :!coffee %<cr>
augroup END

augroup filetype_sql
    autocmd!
    autocmd FileType sql nnoremap <buffer> <localleader>r :!mysql <%<cr>
    autocmd FileType sql vnoremap <buffer> <localleader>r :w !mysql<cr>
augroup END

augroup filetype_markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd BufNewFile,BufReadPost *.md,README set filetype=markdown
augroup END

augroup filetype_snippet
    autocmd!
    autocmd FileType snippet setlocal shiftwidth=8
    autocmd FileType snippet setlocal tabstop=8
    autocmd FileType snippet setlocal softtabstop=8
    autocmd BufWritePost *.snippets call ReloadSnippets(expand('%:t:r'))
augroup END

augroup filetype_go
    autocmd!
    autocmd FileType go setlocal shiftwidth=8
    autocmd FileType go setlocal tabstop=8
    autocmd FileType go setlocal softtabstop=8
    autocmd FileType go setlocal noexpandtab
    autocmd FileType go setlocal keywordprg=go\ doc
    autocmd FileType go nnoremap <buffer> <localleader>f :% !gofmt<cr>
    autocmd FileType go nnoremap <buffer> <localleader>b :make<cr>
    autocmd FileType go nnoremap <buffer> <localleader>r :GoRun %<cr>
augroup END

augroup filetype_java
    autocmd!
    autocmd FileType java nnoremap <buffer> <localleader>b :!javac -Xlint:all %<cr>
    autocmd FileType java nnoremap <buffer> <localleader>r :!javac -Xlint:all % && java %:r<cr>
augroup END

augroup filetype_wxml
    autocmd!
    autocmd BufNewFile,BufReadPost *.wxml set filetype=xml
augroup END

augroup filetype_wxss
    autocmd!
    autocmd BufNewFile,BufReadPost *.wxss set filetype=css
augroup END

augroup filetype_vue
    autocmd!
    autocmd FileType vue set tabstop=2
    autocmd FileType vue set softtabstop=2
    autocmd FileType vue set shiftwidth=2
augroup END

augroup filetype_perl
    autocmd!
    autocmd FileType perl nnoremap <buffer> <localleader>r :!perl %<cr>
    autocmd FileType perl vnoremap <buffer> <localleader>r :w !perl<cr>
augroup END

augroup filetype_ledger
    autocmd!
    autocmd FileType ledger nnoremap <buffer> <localleader>r :!ledger -f % balance<cr>
augroup END

let g:rfc_folding = 1

function! s:GuessPipeFiletype()
    " json
    let l:line_first = getline(1)
    let l:line_last = getline('$')
    if l:line_first[0] == '{' && l:line_last[len(l:line_last)-1] == '}'
                \ || l:line_first[0] == '[' && l:line_last[len(l:line_last)-1] == ']'
        return 'json'
    endif

    " sql
    for l:lnum in range(line('.'), line('$'))
        let l:line = getline(l:lnum)
        if (l:line =~? '\<create database\>'
                    \ || l:line =~? '\<create table\>'
                    \ || l:line =~? '\<insert into\>'
                    \ || l:line =~? '\<delete from\>'
                    \ || l:line =~? '\<alter table\>')
            return 'sql'
        endif
    endfor

    return 'sh'
endfunction

fun! s:SetPipeFiletype() abort
    let l:from_pipe = (argc() == 0) && ((line('.') > 1) || (getline(1) != ''))
    if l:from_pipe
        let l:filetype = s:GuessPipeFiletype()
        execute 'set filetype=' . l:filetype

        if l:filetype == 'json' && line('$') == 1
            exe "1!python -c 'import json, sys; reload(sys); " .
                        \ "sys.setdefaultencoding(\"utf8\"); " .
                        \ "print json.dumps(json.load(sys.stdin), ensure_ascii=False, indent=4)'"
        endif
    endif
endf

fun! s:FindFile() abort
    if argc() == 1 && !filereadable(argv()[0]) && argv()[0][0] == '/' && len(split(argv()[0], '/')) > 0 && !isdirectory('/'.split(argv()[0], '/')[0])
        execute 'NewGrep' '"'.argv()[0][1:].'"'
    endif
endf

augroup filetype_init
    autocmd!
    autocmd VimEnter * call s:SetPipeFiletype()
    autocmd VimEnter * call s:FindFile()
augroup END
" }}}
