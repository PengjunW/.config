
" __     _____ __  __ 
" \ \   / /_ _|  \/  |
"  \ \ / / | || |\/| |
"   \ V /  | || |  | |
"    \_/  |___|_|  |_|
                    

" ====================
" === Editor Setup ===
" ====================
" ===
" === System
" =

let has_machine_specific_file = 1
source $XDG_CONFIG_HOME/nvim/_machine_specific.vim

set clipboard=unnamedplus
let &t_ut=''
set autochdir
set noswapfile

" ===
" === Editor behavior
" ===
set number
set mouse=a
set relativenumber
" 设置光标线
set cursorline
" 设置缩进距离
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
" 自动缩进
set autoindent
" 设置空格的显示
set list  
set listchars=tab:\|\ ,trail:·,extends:⋯,precedes:⋯,nbsp:~
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
" 收起代码
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
" 新窗口显示在右边的下面
set splitright
set splitbelow
set noshowmode
" 显示命令
set showcmd
" 命令模式下，按下Tab 键自动补全
set wildmenu
" 搜索时忽略大小写
set ignorecase
" 只能搜索忽略大小写
set smartcase
set shortmess+=c
" 命令的更改会在preview中显示
set inccommand=split
" 命令补全模式是菜单选择最长的
set completeopt=longest,noinsert,menuone,noselect
" Should make scrolling faster
set ttyfast
" Same as above
set lazyredraw
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
if has('persistent_undo')
        set undofile
        set undodir=~/.config/nvim/tmp/undo,.
endif
" 刷新交换文件所需的毫秒数
set updatetime=1000
" 允许光标出现在最后一个字符的后面
set virtualedit=block,onemore
" 关闭文件又打开光标会自动回到关闭前的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" ===
" === Basic Mappings
" ===

" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "
noremap ; :

"使用jj进入normal模式
inoremap jj <Esc>`^

" Save & quit
inoremap <leader>wq <Esc>:w<cr>
noremap Q :q<CR>
noremap <C-q> :qa<CR>
noremap S :w<CR>

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" make Y to copy till the end of the line
nnoremap Y y$

" Copy to system clipboard
vnoremap Y "+y

" Search 取消搜索高亮
noremap <LEADER><CR> :nohlsearch<CR>

" Folding
noremap <silent> <LEADER>o za

" ===
" === Cursor Movement
" ===

" 大写JKHL重复五次执行
noremap <silent> J 5j
noremap <silent> K 5k
noremap <silent> H 5h
noremap <silent> L 5l

" 设置光标回到行首
noremap <LEADER>a 0

" 设置光标回到行尾
noremap <LEADER>e $

" Faster in-line navigation
noremap W 5w
noremap B 5b

" ===
" === Insert Mode Cursor Movement
" ===

" C-a回到行尾输入
inoremap <C-a> <ESC>A

" ===
" === Command Mode Cursor Movement
" ===

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

" ===
" === Searching
" ===

noremap - N
noremap = n

" ===
" === Window management
" ===

" Use ctrl+h/j/k/l switch window
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Disable the default s key
noremap s <nop>

" Split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap su :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sd :set splitbelow<CR>:split<CR>
noremap sr :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap sh <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>

" ===
" === Tab management
" ===

" Create a new tab with tu
noremap tu :tabe<CR>
" Move around tabs with tn and ti
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>

" ===
" === Markdown Settings
" ===
" Snippets
source $XDG_CONFIG_HOME/nvim/md-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell

" ===
" === Other useful stuff
" ===

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

" Compile function
 noremap r :call CompileRunGcc()<CR>
 func! CompileRunGcc()
 	exec "w"
 	if &filetype == 'markdown'
 		exec "MarkdownPreview"
 	endif
endfunc

" 新建.py
" 定义函数SetTitle，自动插入文件头
function HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
    call append(2, "# Pengjun Wang @ " . strftime('%Y-%m-%d %T', localtime()))
    normal G
    normal o
    normal o
    call setline(5, "if __name__ == '__main__':")
    call setline(6, "    pass")
endf

autocmd bufnewfile *.py call HeaderPython()

" Call figlet
noremap tx :r !figlet 

" Opening a terminal window
" noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>

" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.config/nvim/plugged')

" Pretty Dress
Plug 'ajmwagar/vim-deus'

" Status line
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'

" Startify
Plug 'mhinz/vim-startify'

" devicon
Plug 'ryanoasis/vim-devicons'
Plug 'kristijanhusak/defx-icons'

" General Highlighter
Plug 'RRethy/vim-illuminate'

" File navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

" Taglist
Plug 'liuchengxu/vista.vim'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wellle/tmux-complete.vim'

" Snippets
Plug 'honza/vim-snippets'

" Undo Tree
Plug 'mbbill/undotree'

" Autoformat
Plug 'Chiel92/vim-autoformat'

" Python
Plug 'python-mode/python-mode'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim', { 'for' :['python', 'vim-plug'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }
Plug 'dkarter/bullets.vim'
Plug 'ferrine/md-img-paste.vim'

" Editor Enhancement
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'lfv89/vim-interestingwords'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-repeat'

" Find & Replace
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }

" Bookmarks
Plug 'MattesGroeger/vim-bookmarks'

call plug#end()


" ===================== Start of Plugin Settings =====================

" ===
" === Dress up my vim
" ===
set t_Co=256
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark    " Setting dark mode
colorscheme deus
let g:deus_termcolors=256
hi NonText ctermfg=gray guifg=grey10
hi Normal ctermbg=NONE guibg=NONE

" ===
" === Lightline
" ===
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'deus',
      \ }

" ===
" === Startify
" ===
let g:startify_change_to_dir = 0

" ===
" === coc
" ===
let g:coc_global_extensions = [
  \ 'coc-actions',
  \ 'coc-css',
  \ 'coc-diagnostic',
  \ 'coc-eslint',
  \ 'coc-flutter',
  \ 'coc-git',
  \ 'coc-gitignore',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-lists',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-python',
  \ 'coc-snippets',
  \ 'coc-sourcekit',
  \ 'coc-stylelint',
  \ 'coc-syntax',
  \ 'coc-tasks',
  \ 'coc-translator',
  \ 'coc-tslint',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-yaml',
  \ 'coc-yank']

" Use <tab> for trigger completion and navigate to the next complete item
" <tab>激活补全，<shift+tab>向上选，<tab>向下选,回车键确认
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]	=~ '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Text Objects
" n_coc-funcobj-i 选择函数内所有行，默认映射到if
xmap if <Plug>(coc-funcobj-i)
" n_coc-funcobj-a 选择函数内所有区域，默认映射到af
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Useful commands
" 剪贴板历史记录
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
"跳转到定义位置
nmap <silent> gd <Plug>(coc-definition)
" 跳转到类型定义的位置
nmap <silent> gy <Plug>(coc-type-definition)
" 跳转到实现的位置
nmap <silent> gt <Plug>(coc-implementation)
" 跳转到引用位置
nmap <silent> gr <Plug>(coc-references)

" coc-translator
nmap ts <Plug>(coc-translator-p)
nnoremap <silent> C :call CocActionAsync('doHover')<CR>

" Use F to show documentation in preview window.
nnoremap <silent> F :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-e> <Plug>(coc-snippets-select)
imap <C-j> <Plug>(coc-snippets-expand-jump)
let g:coc_snippet_next = '<c-e>'
let g:coc_snippet_prev = '<c-n>'

" ===
" === python-mode
" ===
"
let g:pymode_python = 'python3'
" 保持文件删除空格
let g:pymode_trim_whitespaces = 1
let g:pymode_run = 1
let g:pymode_run_bind = 'r'
let g:pymode_doc = 1
let g:pymode_doc_bind = 'F'
let g:pymode_rope_goto_definition_bind ="<C-]>" 
let g:pymode_quickfix_maxheight = 3
let g:pymode_indent = 0
let g:pymode_folding = 1
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = "<leader>b"
let g:pymode_breakpoint_cmd = 'import ipdb; ipdb.set_trace()  # BREAKPOINT TODO REMOVE; from nose.tools import set_trace; set_trace()'
" 开启检查
let g:pymode_lint = 1
let g:pymode_lint_on_write = 1
let g:pymode_lint_on_fly = 0
let g:pymode_lint_message = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pylint']
let g:pymode_options_max_line_length = 120
let g:pymode_folding = 0
let g:pymode_rope = 0
let g:pymode_lint_ignore = "C0111, W0105, C0325"
let g:pymode_lint_signs = 1
" let g:pymode_lint_todo_symbol = '😡'
" let g:pymode_lint_error_symbol = '😡'
" let g:pymode_lint_comment_symbol = '😢'
let g:pymode_lint_error_symbol = "\U2717"
let g:pymode_lint_comment_symbol = "\u2757"
let g:pymode_lint_visual_symbol = "\u0021"

" 修改默认的红线为浅色，solorized黑色主题
highlight ColorColumn ctermbg=233
let g:pymode_lint_cwindow = 0
let g:pymode_options_max_line_length = 120
let g:pymode_options_colorcolumn = 1
" 指定UltiSnips python的docstring风格, sphinx, google, numpy
let g:ultisnips_python_style = 'sphinx'

" ===
" === vim-easymotion
" ===
nmap ss <Plug>(easymotion-s2)

" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
			\ 'mkit': {},
			\ 'katex': {},
			\ 'uml': {},
			\ 'maid': {},
			\ 'disable_sync_scroll': 0,
			\ 'sync_scroll_type': 'middle',
			\ 'hide_yaml_meta': 1
			\ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

" ===
" === vim-table-mode
" ===
noremap <LEADER>tm :TableModeToggle<CR>

" ===
" === FZF
" ===
 set rtp+=/usr/local/opt/fzf
 nmap <Leader>ss :<C-u>SessionSave<CR>
 nmap <Leader>sl :<C-u>SessionLoad<CR>
 nnoremap <silent> <Leader>fh :History<CR>
 nnoremap <silent> <Leader>ff :Files<CR>
 nnoremap <silent> <Leader>tc :Colors<CR>
 nnoremap <silent> <Leader>fa :Rg<CR>
 nnoremap <silent> <Leader>fb :Marks<CR>
 noremap <leader>l :Lines<CR>
 noremap <leader>; :History:<CR>

let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" ===
" === defx
" ===
set runtimepath+=~/work/defx.nvim
set runtimepath+=~/work/nvim-yarp/
set runtimepath+=~/work/vim-hug-neovim-rpc/

filetype plugin indent on

call defx#custom#option('_', {
	\ 'columns': 'indent:icons:filename',
	\ 'winwidth': 30,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'listed': 1,
	\ 'show_ignored_files': 0,
	\ 'root_marker': '≡ ',
	\ 'ignored_files':
	\     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
	\   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc,*.swp'
	\ })

call defx#custom#column('mark', { 'readonly_icon': '', 'selected_icon': '' })

" Events
" ---
augroup user_plugin_defx
  autocmd!

  " Define defx window mappings
  autocmd FileType defx call <SID>defx_mappings()

  " Delete defx if it's the only buffer left in the window
  autocmd WinEnter * if &filetype == 'defx' && winnr('$') == 1 | bdel | endif

  " Move focus to the next window if current buffer is defx
  autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif
augroup END

" Internal functions
" ---
function! s:jump_dirty(dir) abort
  " Jump to the next position with defx-git dirty symbols
  let l:icons = get(g:, 'defx_git_indicators', {})
  let l:icons_pattern = join(values(l:icons), '\|')

  if ! empty(l:icons_pattern)
    let l:direction = a:dir > 0 ? 'w' : 'bw'
    return search(printf('\(%s\)', l:icons_pattern), l:direction)
  endif
endfunction


function! s:defx_toggle_tree() abort
  " Open current file, or toggle directory expand/collapse
  if defx#is_directory()
    return defx#do_action('open_or_close_tree')
  endif
  return defx#do_action('multi', ['drop'])
endfunction

function! s:defx_mappings() abort
  " Defx window keyboard mappings
  setlocal signcolumn=no expandtab

  nnoremap <silent><buffer><expr> <CR>  defx#do_action('drop')
  nnoremap <silent><buffer><expr> l     <sid>defx_toggle_tree()
  nnoremap <silent><buffer><expr> h     defx#async_action('cd', ['..'])
  nnoremap <silent><buffer><expr> r     defx#do_action('rename')
  nnoremap <silent><buffer><expr> o     defx#do_action('open', 'botright vsplit')
  nnoremap <silent><buffer><expr> v     defx#do_action('open', 'botright split')
 nnoremap <silent><buffer><expr> dd    defx#do_action('remove_trash')
 " nnoremap <silent><buffer><expr> dd    defx#do_action('remove')
endfunction

let g:maplocalleader='t'
nnoremap <silent> <LocalLeader>tt
\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent> <LocalLeader>tu
\ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

" ===
" === AutoFormat
" ===
autocmd FileType python noremap <leader>p :Autoformat<cr>

" ===
" === Undotree
" ===
noremap <leader>u :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
	nmap <buffer> k <plug>UndotreeNextState
	nmap <buffer> j <plug>UndotreePreviousState
	nmap <buffer> K 5<plug>UndotreeNextState
	nmap <buffer> J 5<plug>UndotreePreviousState
endfunc

" ===
" === Vista.vim
" ===
noremap <LEADER>v :Vista coc<CR>
noremap <c-t> :silent! Vista finder coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" ===
" === Vim-interestingwords
" ===
"K键高亮或者取消
nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
nnoremap <silent> <leader>K :call UncolorAllWords()<cr>
nnoremap <silent> n :call WordNavigation('forward')<cr>
nnoremap <silent> N :call WordNavigation('backward')<cr>

" ===
" === Bullets.vim
" ===
let g:bullets_enabled_file_types = [
			\ 'markdown',
			\ 'text',
			\ 'gitcommit',
			\ 'scratch'
			\]

" ===
" === vim-markdown-toc
" ===
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'

" ===
" === vim-markdown-toc
" ===
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
let g:mdip_imgdir = './pic'
" let g:mdip_imgname = 'image'


" ===
" === repeat
" ===
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" ===
" === braceless
" ===
autocmd FileType python BracelessEnable +indent +fold

" ===
" === rnvimr
" ===
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_draw_border = 0
" let g:rnvimr_bw_enable = 1
highlight link RnvimrNormal CursorLine
nnoremap <silent> R :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]

