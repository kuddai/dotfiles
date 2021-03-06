" Increase terminal keyboard speed on Mac OS X:
" defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
" defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)
" 
" Swap capslock to escape on Linux:
" "setxkbmap -option caps:escape"
" Permamently, add it to
" ~/.xinitrc or ~/.xsession
" Or edit XkbOptions section here
" /etc/X11/xorg.conf.d/00-keyboard.conf
" Section "InputClass"
"        Identifier      "system-keyboard"
"        MatchIsKeyboard     "on"
"        Option          "XkbLayout" "us"
"        Option          "XkbModel"  "pc104"
"        Option          "XkbOptions" "caps:swapescape"
" EndSection

" SETTINGS

" Enable modern vim (not vi).
set nocompatible
set encoding=utf-8

filetype plugin indent on
filetype plugin on
" Css autocomplete on |Insert mode| ctrl + x, ctrl + o
" https://www.simplified.guide/vim/auto-complete-css
" https://medium.com/vim-drops/css-autocompletion-on-vim-no-plugins-needed-e8df9ce079c7
autocmd FileType scss set omnifunc=csscomplete#CompleteCSS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" Enable syntax highlighting.
syntax on
" Left column with line numbers.
set number
" Tab to spaces.
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
" Allow backspace to delete in insert mode.
set backspace=indent,eol,start
" Wrap characters visually into next line after 190 symbols.
set tw=190
" Jumps to the next time while typing search query.
set incsearch
" Highlight search (disable highlighting with :noh).
set hlsearch
" Display current cursor position in right bottom corner.
set ruler
" Vim flashes screen instead of annoying beep sound.
set visualbell
" By default enable case insensitive search.
set ignorecase
" But if you use capital letters in your search query then search switches
" to case sensitive search mode (hence smart part).
set smartcase
" Exclude from file search.
set wildignore+=.git,**/node_modules/**,*.pyc,*.bak,*.class,*.jar,*jpg,*.png

" From this talk:
" https://www.youtube.com/watch?v=XA2WjJbmmoM
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
" Display all matching files when we tab complete
set  wildmenu


" PLUGINS

" Using "plug" manager: https://github.com/junegunn/vim-plug
" To install :PlugInstall
call plug#begin('~/.vim/plugged')
" Toggle between source and header file
Plug 'vim-scripts/a.vim'
" My favorite Monokai theme.
Plug 'flazz/vim-colorschemes'
" Emmit style support.
" Use "ctrl+y," to expand Emmet expressions.
Plug 'mattn/emmet-vim'
" Adds :Ack , enhance with The Silver Searcher "Ag" for faster search.
Plug 'mileszs/ack.vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" Vim autocomplte
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree'
" Syntax highlighting (probably can live without it).
Plug 'scrooloose/syntastic'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" Intelectual replace regardless of camel case.
" :%S/abba/moba -> Abba -> Moba
" :%S/facilit{y,ies}/building{,s}/g
Plug 'tpope/vim-abolish'
" Git helper, not that much needed with :Shell, although helpfull during merge.
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
" Press to replace quotes cs"'
" "Hello world!" -> 'Hello world!'
Plug 'tpope/vim-surround'
" Leveraging MS language server for proper autocompletion in YCM:
"
" https://langserver.org/
" https://clang.llvm.org/extra/clangd/Installation.html
"
" For cpp family looks for the file compile_commands.json
" * If using CMake, add -DCMAKE_EXPORT_COMPILE_COMMANDS=ON when configuring (or
"   add set( CMAKE_EXPORT_COMPILE_COMMANDS ON ) to CMakeLists.txt) and copy or
"   symlink the generated database to the root of your project.
" * If using Ninja, check out the compdb tool (-t compdb) in its docs.
" * If using GNU make, check out compiledb or Bear.
"
" For javascript related support (--ts-completer) needs jsconfig.json, for e.g.
" npm and node are required.
" {
"     "compilerOptions": {
"         "target": "ES6",
"         "module": "commonjs",
"         "allowSyntheticDefaultImports": true
"     },
"     "exclude": [
"         "dist",
"         "node_modules"
"     ]
" }
"" Too many freezes
" Plug 'valloric/youcompleteme', { 'do': './install.py --clangd-completer --ts-completer' }
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ryanolsonx/vim-lsp-typescript'
" Bottom status line.
Plug 'vim-airline/vim-airline'
" Control key + t -> index files and quick search. Vim must be compiled with
" ruby support
Plug 'wincent/command-t', { 'do': 'cd ./ruby/command-t/ext/command-t/; make clean; ruby extconf.rb; make' }
" Kuddai code annotations plugin.
" Plug 'file://'.expand('~/.vim/plugged/vim-code-annotations')
" Initialize plugin system
Plug 'yasukotelin/shirotelin'
call plug#end()


" CONFIGS

let mapleader=','

" Command-T max number of files indexed
let g:CommandTMaxFiles=2700000
" Command-T additional git ignore
let g:CommandTWildIgnore=&wildignore . ",*/bazel-out,*/bazel-sdc,*/bazel-bin"

" NERDTree
let g:NERDTreeWinSize=35

" Emmet
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

"Prettier
let g:prettier#autoformat_config_present = 1

" YouCompleteMe.
" Remove help type annotation window.
" https://github.com/Valloric/YouCompleteMe#i-get-a-weird-window-at-the-top-of-my-file-when-i-use-the-semantic-engine
set completeopt-=preview
let g:ycm_add_preview_to_completeopt=0
let g:ycm_server_use_vim_stdout = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']
" Automatically select first option.
let g:neocomplete#enable_auto_select = 1

" Clangd special support https://clang.llvm.org/extra/clangd/Installation.html
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")

" Default ycm cpp preferences.
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" vim-markdown, add code highlighting for those languages in markdown.
let g:markdown_fenced_languages = ['html', 'javascript', 'c++=cpp', 'python', 'bash=sh']

" vim-colorschemes
" colorscheme peachpuff
colorscheme shirotelin


" chrome autocomplete setup
let s:cwd = getcwd()

" Update with "Ag" if available.
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Override colorscheme with transparent background.
hi Normal guibg=NONE ctermbg=NONE

" Check file for updates after cursors stops moving, by default triggered each
" 4 seconds.
au CursorHold,CursorHoldI * checktime

" davidhalter/jedi-vim
" python settings
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0

" ITS hotkeys
" let g:jedi#goto_command = "<leader>d"
" let g:jedi#goto_assignments_command = "<leader>g"
" let g:jedi#goto_stubs_command = "<leader>s"
" let g:jedi#goto_definitions_command = ""
" let g:jedi#documentation_command = "K"
" let g:jedi#usages_command = "<leader>n"
" let g:jedi#completions_command = "<C-Space>"
" let g:jedi#rename_command = "<leader>r"

" HOTKEYS

" NERDTree.
" ctrl+N -> toggle NERDTree window.
nmap <silent> <C-N> :NERDTreeToggle<CR>
" ,+f -> opens NERDTree on current file.
nnoremap <leader>f :NERDTreeFind<CR>

" LSP autocomplete.
nnoremap <leader>gf :LspDeclaration<CR>
nnoremap <leader>gg :LspDefinition<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

let g:lsp_settings = {
\  'clangd': {'cmd': ['clangd-9']},
\  'typescript-language-server': {'cmd': ['typescript-language-server']}
\}
let g:lsp_signature_help_enabled = 0

" Kuddai annotation plugin -> starts/stops annotations.
" nnoremap <leader>j :KuddaiAnnotate<CR>
" nnoremap <leader>k :KuddaiFinish<CR>
nnoremap <leader>j :A<CR>

" Toggle between header and soure, more work is needed here.
" old way nnoremap t :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" new way
" map t :call SwitchSourceHeader()<CR>

" Open buffers and choose corret one.
nnoremap <leader>bb :buffers<cr>:b<space>

" yank relative file path
nnoremap <leader>cp :let @" = expand("%")<cr>


" SCRIPTS
"Switch between C++ header/source
function! SwitchSourceHeader()
      "update!
    if (expand ("%:e") == "cpp")
        find %:t:r.h
    else
        find %:t:r.cpp
    endif
endfunction

" Highlight launch files as xml.
autocmd BufEnter *.launch :setlocal filetype=xml

" Remember line in the previously opened file.
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" Allow to open command output into the scratch buffer which won't be saved
" once closed.
" Example usage :Shell ls -la
" Taken from:
" https://vim.fandom.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction
