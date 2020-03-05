" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'belltoy/vim-protobuf'
Plug 'bfrg/vim-cpp-modern'
" Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/OmniCppComplete'
Plug 'ervandew/supertab'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-janah'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'skywind3000/gutentags_plus'
Plug 'skywind3000/vim-preview'
Plug 'elzr/vim-json'
Plug 'Yggdroot/indentLine'

" Initialize plugin system
call plug#end()

filetype on
syntax on
set nocompatible
set number
set hlsearch
set backspace=2
set history=1000 
" set background=dark 
set noignorecase
" " 
set enc=utf8 
set fencs=utf8,gbk,gb2312,gb18030,cp936
" 
set autoindent
set smartindent
" 
set tabstop=4
set shiftwidth=4
set expandtab ts=4 sw=4 sts=4
"       
set showmatch
" 
set incsearch
set nobomb


set viminfo='1000,<5000
colorscheme molokai
let g:rehash256 = 1
set t_Co=256
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE

let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:airline_theme='molokai'

let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
set tags+=./.tags;,.tags
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_define_advanced_commands = 1 
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxN']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--fields-c++=+{properties}']
let g:gutentags_ctags_exclude = ['*.js', '*.json']

" universal ctags 使用
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0


let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全
" let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" 自动关闭补全窗口
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest
" -- ctags --
" map +F12 to 清理tag:
map <F12> :!rm -rf ~/.cache/tags/*<CR>
"
nmap <F8> :TagbarToggle<CR>
nmap <F7> :NERDTreeToggle<CR>
nmap <F4> :ccl<CR>
set pastetoggle=<F2>

" vim 强制学习
nmap <Up> <Nop>
nmap <Down> <Nop>
nmap <Left> <Nop>
nmap <Right> <Nop>

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

"quickfix
" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
autocmd FileType qf nnoremap <silent><buffer> q :cclose<cr>

" use astyle to auto format cpp/h files
map <F5> :call CodeFormat()<CR>
func! CodeFormat()
        let lineNum = line(".")
        if &filetype == 'cpp' || &filetype == 'h' || &filetype == 'hpp'
            exec "%!astyle -A1 -s4 -k1 -YHNOUSpC"
        endif
        exec lineNum
endfunc

" auto format when save cpp/h files
autocmd BufWritePre,FileWritePre *.cpp,*.h,*.hpp ks|call CodeFormat()|'s
