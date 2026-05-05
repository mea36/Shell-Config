" Plugin management is handled by lazy.nvim (see init.lua)

" settings that need to happen before plugins are loaded
let g:ale_completion_enabled = 1

set rtp+=/usr/local/go/misc/vim
syntax on

" backspace fix
set backspace=2

" add padding to the left of the window by utilzing the signcolumn
set signcolumn=yes

" New leader
let mapleader=","

" Yank, comment, paste.
nmap <leader>y yy,c<space>p
vmap <leader>y yygv,c<space>p

" Various copy/paste niceties (assumes pbcopy/pbpaste is installed)
vmap <leader>c ! pbcopy<CR>:undo<CR>
nmap <leader>v :set paste<CR>! pbpaste<CR>:set nopaste<CR>

"status line
:set laststatus=2 " Always show status bar
:set statusline=%f\ %y%r\ [%l,%c]\ %P " show relative path
":set statusline=%t\ %y%r\ [%l,%c]\ %P " show filename
:set statusline+=%*

" Get rid of the topbar on gui mode
set guioptions-=T


" Colors!
syntax enable
syntax on
" for tender
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
    set termguicolors
endif


"set background=dark
if has('nvim')
  colorscheme tender
  set fillchars+=vert:│
  highlight WinSeparator guifg=#444444 guibg=NONE
endif


" Solarized background strangeness fix
"highlight Normal ctermbg=none

"Set linenumber stuff
"set numberwidth=5
highlight LineNr   guifg=#bbbbbb ctermfg=250 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
:set number

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" toggle lin numbers off
nmap <leader>nu :set rnu! nu!<CR>

"Set reasonable colors for pyflakes highlighting
"hi SpellBad cterm=underline ctermbg=0

" Enable filetype support for awesome plugin goodness
filetype on
filetype plugin on
filetype plugin indent on

" bash-like file completion
set wildmode=longest,list

"Allow moving to the end of the line in visual block mode
set virtualedit+=block

"Highlight search results
set hlsearch

"tabs
set softtabstop=2 " used to be 4
set shiftwidth=2 " used to be 4
set expandtab
set tabstop=2 " used to be 4
set smarttab
set smartindent
set autoindent

"Search config
set ignorecase
set smartcase
set incsearch

"no mouse click
set mouse=""

"you can enter a terminal with :term, map exiting to <leader><esc>
:tnoremap <leader><Esc> <C-\><C-n>


"Finding keeps cursor in the middle of the screen
nnoremap n nzz

":nmap - Display normal mode maps
":imap - Display insert mode maps
":vmap - Display visual and select mode maps
":smap - Display select mode maps
":xmap - Display visual mode maps
":cmap - Display command-line mode maps
":omap - Display operator pending mode maps

"Leave insert mode with `jk` (avoid escape!)
imap jk <Esc>

"the original gf
map GF gf

"vsp the file under the cursor
map gv :vertical wincmd f<CR>

"open file in new tab (similar to gf) with `gf`
map gf <C-w>gf

"map gT (go back a tab) to GT
map GT gT

"map <leader><Space> to add a space to the right of the cursor
nmap <leader><Space> a<Space><Esc>

"map <leader><Enter> to add a new line below the cursor
nmap <leader><CR> o<Esc>

"map ,nohl remove highlights
nmap <leader>nohl :nohl<CR>

" unmap arrow keys
"nmap <right> <nop>
"nmap <left> <nop>
"nmap <up> <nop>
"nmap <down> <nop>
"imap <right> <nop>
"imap <left> <nop>
"imap <up> <nop>
"imap <down> <nop>

" More intuitive motions through wrapped lines
set linebreak
nnoremap gj j
nnoremap gk k


"http://vim.wikia.com/wiki/VimTip1608
set tags+=~/.vim/tags/alltags
" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+lp --fields=+iaS --extra=+q .<CR>

"Reload all buffers with F4
nmap <F4> :bufdo e!<CR>

" Opens tagbar with F2
map <F2> :TagbarToggle<CR>

" general ctypes location
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'

" ctype settings for go:
" https://github.com/jstemmer/gotags
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

" Open NERDTree with F3
map <leader>nt :NERDTreeFind<CR>
" Filter out annoying files in nerdtree
let NERDTreeIgnore = ['\.pyc$', '\.sw[op]$']

" Open GunDo with F5
map <F5> :GundoToggle<CR>

"Window Resizing
map <C-A-l> <C-w>>
map <C-A-k> <C-W>-
map <C-A-j> <C-W>+
map <C-A-h> <C-w><

map <C-l> 5<C-w>>
map <C-k> 5<C-W>-
map <C-j> 5<C-W>+
map <C-h> 5<C-w><

"Tab Movement and creation
:map <C-S-tab> :tabprevious<CR>
:map <C-tab> :tabnext<CR>
:imap <C-S-tab> <Esc>:tabprevious<CR>i
:imap <C-tab> <Esc>:tabnext<CR>i
:nmap <C-S-t> :tabnew<CR>
:imap <C-S-t> <Esc>:tabnew<CR>

"Fold on preprocessor definitions
autocmd FileType [ch] call FoldPreprocessor()
function! FoldPreprocessor()
    set foldmarker=#if,#endif
    set foldmethod=marker
endfunction
set foldmethod=syntax
if has("autocmd")
  " declares an automatic command (au), triggered when a buffer is read (BufRead), matching all files (*) and executes the zR (opens all folds) command in normal mode.
  au BufRead * normal zR
endif

"Make asciidoc easier to work with
autocmd FileType asciidoc :set tw=80

"In normal mode, press Space to toggle the current fold open/closed. However, if
"the cursor is not in a fold, move to the right (the default behavior). In
"addition, with the manual fold method, you can create a fold by visually
"selecting some lines, then pressing Space.
" http://vim.wikia.com/wiki/Folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" unfold all - zR


"Tabline
if exists("+guioptions")
     set go-=e
endif
if exists("+showtabline")
     function MyTabLine()
         let s = ''
         let t = tabpagenr()
         let i = 1
         while i <= tabpagenr('$')
             let buflist = tabpagebuflist(i)
             let winnr = tabpagewinnr(i)
             let s .= ' %' . i . 'T'
             let s .= (i == t ? '%1*[' : '%2*%#TabLineFill#(')
             let s .= i

             let modified = 0
             for curbuf in buflist
               let modified += getbufvar(curbuf, "&modified")
             endfor
             if modified > 0
               let s .= '*'
             else
               let s .= '-'
             endif

             let s .= '%*'
             let s .= (i == t ? '%#TabLineSel#' : '')
             let file = bufname(buflist[winnr - 1])
             let file = fnamemodify(file, ':p:.:t')
             if file == ''
                 let file = '[No Name]'
             endif
             let s .= file
             if tabpagewinnr(i,'$') > 1
               let s .= '/' . tabpagewinnr(i,'$')
             endif
             let s .= (i == t ? '%#TabLineFill#]' : ')')
             let s .= ' '
             let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%='
         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
         return s
     endfunction
     set stal=2
     set tabline=%!MyTabLine()
endif

fun! GrepWord()
    let s:term = expand('<cword>')
    :exe ":!grep --color=always -r " . s:term . " *"
endfun

fun! SearchGit()
    let s:term = expand('<cword>')
    :exe ":!git grep " . s:term . ""
endfun

fun! SearchGitNvim()
    let s:term = expand('<cword>')
    :exe ":split"
    :call feedkeys("\<C-w>j")
    :call feedkeys(":term\<CR>")
    :call feedkeys("agit grep " . s:term . "\<CR>")
endfun

fun! GrepWordPipeOut()
    let s:term = expand('<cword>')
    :exe ":!grep --color=always -r " . s:term . " * > out"
endfun

fun! GitGrepWordPipeOut()
    let s:term = expand('<cword>')
    :exe ":!git grep -i " . s:term . " > out"
endfun

map sear :call GrepWord()<CR>
map fsear :call GrepWordPipeOut()<CR>
map fgsear :call GitGrepWordPipeOut()<CR>
map sg :call SearchGitNvim()<CR>
map <leader>g :GBrowse<CR>
let g:github_enterprise_urls = ['https://github.com/chromaui/', 'https://github.com/chromaui/chromatic-e2e']

fun! TabWithGitStatus()
  " open new tab
  :tabnew
  " open Git
  :Git
endfun
command Tstatus :call TabWithGitStatus()

" format json
command JSON :%!python3 -m json.tool

"create command to open a new tab with nerd tree
fun! TabWithFileDir()
    " open new tab
    :tabnew %
    " open nerd tree
    ":NERDTreeToggle
    :NERDTreeFind
endfun
command TT :call TabWithFileDir()

" convert page of
" [filename]: [line of code]
" to
" [filename]
fun! ListFiles()
    " remove everything after the colon
    :%s/:.*$//g
    " remove duplicates
    :sort u
endfun
command Listfiles :call ListFiles()


" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
    try
        let selection = system(a:choice_command . " | selecta " . a:selecta_args)
    catch /Vim:Interrupt/
        " Swallow the ^C so that the redraw below happens; otherwise there will be
        " leftovers from selecta on the screen
        redraw!
        return
    endtry
    redraw!
    exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
"nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>
"selecta doesn't work in neovim so trying:



" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" ale
let g:ale_fix_on_save = 1 " when this fixes things you don't want touched, set to 0
let g:ale_floating_preview = 1
let g:ale_floating_window_border = [' ', ' ', ' ', ' ', ' ', ' ']
map <leader>u :ALEFindReferences<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> gds :ALEGoToDefinition -split<CR>
nnoremap <silent> gdt :ALEGoToDefinition -tab<CR>
nnoremap <silent> gdv :ALEGoToDefinition -vsplit<CR>
nnoremap <silent> gk :ALEDetail<CR>
let g:ale_elixir_elixir_ls_release = '/opt/homebrew/opt/elixir-ls/libexec'
let g:ale_linter_aliases = {'astro': ['css', 'javascript', 'typescript']}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
"\   'astro': ['eslint', 'stylelint', 'prettier'],
\   'css': ['stylelint', 'prettier'],
\   'javascript': ['eslint', 'prettier'],
\   'json': ['fixjson', 'prettier'],
\   'html': ['prettier'],
\   'markdown': ['remark-lint', 'prettier'],
\   'elixir': ['mix_format'],
\   'python': ['ruff', 'ruff_format'],
"\   'ruby': ['rubocop'],
"\   'rust': ['rustfmt'],
"\   'scss': ['stylelint'],
\   'sh': ['shfmt'],
"\   'svelte': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
"\   'vue': ['eslint', 'prettier'],
\}
" TODO: add tsserver to astro. tsserver seems to parse a whole Astro file as TypeScript.
let g:ale_linters = {
\   'astro': ['eslint', 'stylelint'],
\   'css': ['stylelint'],
\   'elixir': ['elixir-ls', 'credo', 'dialyxir', 'dogma'],
\   'handlebars': ['ember-template-lint'],
\   'html': [],
\   'javascript': ['eslint', 'tsserver'],
\   'markdown': ['remark-lint'],
"\   'python': ['mypy', 'pylsp', 'ruff'],
\   'typescript': ['eslint', 'tsserver'],
"\   'vue': ['eslint', 'vls'],
\}
set omnifunc=ale#completion#OmniFunc


" fzf
" map to ,f
nmap <leader>f :Files <CR>

" Something you're  doing keeps on folding all the things
nmap <leader>uf zR

" work specific
" output console.log('mea36 '); below cursor
nmap <leader>l oconsole.log(`mea36 `);<ESC>hh
nnoremap <leader>lg :LazyGit<CR>
