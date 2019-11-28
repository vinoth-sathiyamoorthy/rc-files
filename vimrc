set backspace=indent,eol,start
set number
set laststatus=2
set updatetime=100 "This time is used by GitGutter
"set paste
"split settings
set splitbelow "new window below
set splitright "new window to right
"visual mode on mouse click
set mouse=a
"Highlight search setting
set hlsearch "highlight results
set incsearch "search as i type
set ignorecase "ignore case while searching
set smartcase "do not ignore uppercase
"Remembers last known cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
"================VIM-PLUG============
call plug#begin('~/.vim/plugged')
Plug 'NLKNguyen/papercolor-theme' "Colorscheme

Plug 'zoushuai518/Trinity' "Source code browser
Plug 'vim-scripts/taglist.vim' "used by trinity
Plug 'vim-scripts/SrcExpl' "Source Explorer, uses ctags, used by trinity

Plug 'tpope/vim-fugitive' "adds git branch info to the airline info bar
Plug 'vim-airline/vim-airline' "top and bottom information bar
Plug 'vim-airline/vim-airline-themes' "top and bottom information bar

Plug 'airblade/vim-gitgutter' "marks modified lines
Plug 'google/vim-searchindex' "indexed searching

Plug 'junegunn/fzf.vim'
Plug 't9md/vim-quickhl' "text highlighting

Plug 'tpope/vim-unimpaired' "change to different buffer

Plug 'Yggdroot/indentLine' "to mark code blocks with vertical lines
call plug#end()
"============PLUGIN END==============

"============KEYMAPS=================
"The Leader
let mapleader="\<Space>"
"replace the word under cursor - Space + *
nnoremap <leader>* :%s/\<<c-r><c-w>\>//c<left><left>
"sudo write"
nnoremap <C-s> :w !sudo tee %<CR>
"autoclose tags 
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap " ""<Left>
"ctags without leaving vim - Space + ct
"set tags+=.git/tags
"nnoremap <leader>ct :!ctags -Rf .git/tags --tag-relative --extra=+f --exclude=.git,pkg --languages=-sql<cr><cr>
"Ctrl-c to copy to clipboard
nmap <2-LeftMouse> <Plug>(quickhl-manual-this)
xmap <LeftMouse> <Plug>(quickhl-manual-reset)
nmap <C-f> <Plug>(quickhl-manual-this)
xmap <C-f> <Plug>(quickhl-manual-reset)
"**********************************"
"Trinity
nmap <F8> :TrinityToggleAll<CR>
nmap <F7> :TrinityToggleSourceExplorer<CR>
nmap <F5> :TrinityToggleTagList<CR>
nmap <F6> :TrinityToggleNERDTree<CR>
"Gitgutter
nmap hn :GitGutterNextHunk<CR>
nmap hj :GitGutterPrevHunk<CR>
nmap hp :GitGutterPreviewHunk<CR>
nmap hu :GitGutterUndoHunk<CR>
nmap hs :GitGutterStageHunk<CR>
"**********************************"
"indentLine
nmap <C-i> :IndentLinesToggle<CR>

"==============END===================

"=============SETTINGS===============
"PLUGIN: Papercolor color scheme
set t_Co=256   " This is may or may not needed.
set background=dark
colorscheme PaperColor

let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }
"------------------------------------------------------------------------------------
"PLUGIN: SrcExpl [used by Trinity]
let g:SrcExpl_jumpKey = "<ENTER>" "Jump to definition
let g:SrcExpl_gobackKey = "<SPACE>" "Jump back from definition
" // In order to avoid conflicts, the Source Explorer should know what plugins "
" // except itself are using buffers. And you need add their buffer names into "
" // below listaccording to the command ":buffers!"                            "
 let g:SrcExpl_pluginList = [
         \ "__Tag_List__",
         \ "_NERD_tree_",
         \ "Source_Explorer"
     \ ]
let g:SrcExpl_colorSchemeList = [
         \ "Red",
         \ "Cyan",
         \ "Green",
         \ "Yellow",
         \ "Magenta"
     \ ]
let g:SrcExpl_searchLocalDef = 1
let g:SrcExpl_nestedAutoCmd = 1
let g:SrcExpl_isUpdateTags = 0
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."
let g:SrcExpl_updateTagsKey = "<F2>"
let g:SrcExpl_prevDefKey = "<F3>"
let g:SrcExpl_nextDefKey = "<F4>"
"------------------------------------------------------------------------------------
"PLUGIN: Airline - [needs papercolor colorscheme and fugitive]
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='papercolor' "change if colorscheme is changed
"""------------------------------------------------------------------------------------
""PLUGIN: Gitgutter - mark modified lines
let g:gitgutter_max_signs = 500  " default value
""let g:gitgutter_sign_added = '▲'
""let g:gitgutter_sign_modified = '▶'
""let g:gitgutter_sign_modified_removed = '▼'
""let g:gitgutter_sign_removed = '▼'
""let g:gitgutter_sign_removed_first_line = '▲'
"------------------------------------------------------------------------------------
"PLUGIN: indentLine - mark code blocks with vertical line
let g:indentLine_setColors = 0
"let g:indentLine_color_term = 239
"let g:indentLine_bgcolor_term = 202
"let g:indentLine_bgcolor_gui = '#FF5F00'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']  "each indent level has a diff char

"===========SETTINGS END=============
