" SETTINGS

" Enable modern vim (not vi).
set nocompatible
set encoding=utf-8
filetype plugin indent on
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
set wildignore+=.git


" PLUGINS

" Using "plug" manager: https://github.com/junegunn/vim-plug
" To install :PlugInstall
call plug#begin('~/.vim/plugged')
" My favorite Monokai theme.
Plug 'flazz/vim-colorschemes'
" Emmit style support.
" Use "ctrl+y," to expand Emmet expressions.
Plug 'mattn/emmet-vim'
" Adds :Ack , enhance with The Silver Searcher "Ag" for faster search.
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
" Syntax highlighting (probably can live without it).
Plug 'scrooloose/syntastic'
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
Plug 'valloric/youcompleteme', { 'do': './install.sh --clangd-completer --ts-completer' }
" Bottom status line.
Plug 'vim-airline/vim-airline'
" Control key + t -> index files and quick search. Vim must be compiled with
" ruby support
Plug 'wincent/command-t', { 'do': 'ruby ./ruby/command-t/ext/command-t/extconf.rb; make -C ./ruby/command-t/ext/command-t/' }
" Kuddai code annotations plugin.
Plug 'file://'.expand('~/.vim/plugged/vim-code-annotations')
" Initialize plugin system
call plug#end()


" CONFIGS

let mapleader=','

" Command-T max number of files indexed
let g:CommandTMaxFiles=2700000

" NERDTree
let g:NERDTreeWinSize=35

" Emmet
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

" YouCompleteMe.
" Remove help type annotation window.
" https://github.com/Valloric/YouCompleteMe#i-get-a-weird-window-at-the-top-of-my-file-when-i-use-the-semantic-engine
set completeopt-=preview
let g:ycm_add_preview_to_completeopt=0
let g:ycm_server_use_vim_stdout = 1
let g:ycm_server_log_level = 'debug'
" Automatically select first option.
let g:neocomplete#enable_auto_select = 1

" Clangd special support https://clang.llvm.org/extra/clangd/Installation.html
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")

" vim-markdown, add code highlighting for those languages in markdown.
let g:markdown_fenced_languages = ['html', 'javascript', 'c++=cpp', 'python', 'bash=sh']

" vim-colorschemes
colorscheme Monokai

" chrome autocomplete setup
let s:cwd = getcwd()

" Update with "Ag" if available.
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Override colorscheme with transparent background.
hi Normal guibg=NONE ctermbg=NONE


" HOTKEYS

" NERDTree.
" ctrl+N -> toggle NERDTree window.
nmap <silent> <C-N> :NERDTreeToggle<CR>
" ,+f -> opens NERDTree on current file.
nnoremap <leader>f :NERDTreeFind<CR>

" YouCompleteMe.
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Kuddai annotation plugin -> starts/stops annotations.
nnoremap <leader>j :KuddaiAnnotate<CR>
nnoremap <leader>k :KuddaiFinish<CR>


" SCRIPTS

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
