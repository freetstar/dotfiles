" 设置vim{{{1
" 需要下载中文vim帮助包
set helplang=cn
"设置vim要记住的历史书目
set history=5000
"激活鼠标
"set mouse=a
"打开文件检测
filetype plugin indent on
"不包裹行
set nowrap
"设置encoding
set encoding=utf-8
"语法高亮
syntax on
"设置文件类型
set ffs=unix,dos,mac
"颜色主题
let g:molokai_original = 1
"显示行号
set nu
"自动重载文件
set autoread
"自动补全命令时使用菜单式匹配列表
set wildmenu
"显示未完成的命令
set showcmd
"设置mapleader,用来做leader
let mapleader = ","
let g:mapleader = ","
"突出显示当前行
set cursorline
""Ignore case when searching
set ignorecase 
set smartcase
set hlsearch
set incsearch
set mat=2
"出现错误时不报警
set noerrorbells
set novisualbell
"设置列数
"set colorcolumn=81
"设置终端
set shell=/bin/zsh
"备份
set nobackup
set nowb
set noswapfile
"设置长行的显示方式,长行分隔显示
set lbr
"设置textwidth的最长行
set tw=500
"一般在c,python语言的开头会有关于vim的tab定义,
set modeline
"设置paste，从剪贴板年铁代码，保持代码原有的风格
"set paste   //目前于sniptext有冲突
"将系统用ctag生成的systags包括
set tags+=~/.vim/systags

"""""""""""""""""""""'"tab设置"""""""""""""""""""""""""'
"在插入tab时，插入的不是tab字符，而是相等数量的space字符
set expandtab
"设置用<>在可视化模式下进行缩进的宽度
set shiftwidth=4
"默认的tab宽度
set tabstop=4
"当在一个行首时，插入tab[s]时，选择shiftwidth设置，而不是tabstop设置
set smarttab
"让vim在删除tab时，将多个space识别为一个tab进行操作,免除敲4个backspace
set softtabstop=4

" 用来打开list功能，显示不可见字符
nmap <leader>l :set list!<CR>
" 设置为>-格式
set listchars=tab:>-,eol:$

"1}}}

"设置折叠{{{2
"set foldcolumn=4
"python专用
set foldmethod=syntax
"
"2}}}

"配置vim字体和颜{{{3
if has("gui_running")
    "关闭工具栏
    set guioptions-=T
    set t_Co=256
    set background=light
    "colorscheme solarized
    colorscheme molokai
    set nu
else 
    set background=dark
    "colorscheme solarized
    colorscheme  desert
    set nu
endif
"
"3}}}

"设置状态栏5}}}
"最后一个window总有状态栏
set laststatus=2
"设置状态栏的路径
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction
"5}}}

""""""""""""""""""""""""""""""""""""""""""""""""
"vim配置界面
""""""""""""""""""""""""""""""""""""""""""""""
"设定ruler
"Always show current position
set ruler 
"搜索选项

"出现错误时不响
set noerrorbells
set novisualbell

"置空错误铃声的终端代码
set t_vb=


"''''''''''''''''''''''''''''''''''''''''''''''''快捷键映射

"!复制时不带行号
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
"进行快速保存
nmap <leader>w :w!<cr>
"快速编辑vimrc文件
map <leader>e :e! ~/.vimrc<cr> 
"按下*或者#时搜索当前光标所在单词
vnoremap <silent> * :cakk VisualSearch('f')<CR>
vnoremap <silent> # :cakk VisualSearch('b')<CR>
"将空格映射为/，c-space为？
map <space> /
map <c-space> ?
"设置( { [ < 自动配对
"    :inoremap ( ()<ESC>i
"    :inoremap ) <c-r>=ClosePair(')')<CR>
"    :inoremap { {}<ESC>i
"    :inoremap } <c-r>=ClosePair('}')<CR>
"    :inoremap [ []<ESC>i
"    :inoremap ] <c-r>=ClosePair(']')<CR>
"    :inoremap < <><ESC>i
"    :inoremap > <c-r>=ClosePair('>')<CR>
"    :inoremap < <><ESC>i
"    :inoremap > <c-r>=ClosePair('"')<CR>
"设置多窗口协作
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
"map <c-v> <c-w>v
"设置TaskList
map <leader>td <Plug>TaskList
"设置行号
nnoremap <F3> :set nonumber!<CR>:set foldcolumn=0<CR>

"用shift+e来调用python执行当前py文件
map  <S-e> :!/usr/bin/python2 %<CR>

"动态打开paste
map <leader>pp :setlocal paste!<cr>

"F2取消单词的高亮
nmap <F2> :nohlsearch<CR>
"F5显示行号或者否
map <F3> :set number!<CR>
map tn :tabnext<cr>
map tp :tabprevious<cr>
"参考资料
"
"http://www.vex.net/~x/python_and_vim.html
"

"vim Tricks {{{

"当vimrc被重新编辑时，重新载入他
autocmd! bufwritepost .vimrc source ~/.vimrc
"打开文件时，总是跳到退出之前的光标处
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
"}}}
"}}}

"''''''''''''''''''''''''''''''''''''''Python'''''''''''''''
autocmd BufRead,BufNewFile  *.py syntax on
autocmd BufRead,BufNewFile  *.py set foldmethod=indent
autocmd BufRead,BufNewFile  *.py set autoindent
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,with,try,except,finally,def,class
"移除行末多余的空白符
autocmd BufWritePre *.py normal m`:%s/\s\+$//e
"在import file的file那里gf，则可以跳到import的文件中去
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF
"设置tag
set tags+=$HOME/.vim/tags/python.ctags
"更自然的跳转
nmap <slient><C-Left> <C-T>
nmap <slient><C-Right> <C-]>
"(当前没有这些模板文件)自动使用新文件模板
autocmd BufNewFile *.py 0r ~/.vim/skeleton/skeleton.py
"pydoc,按下<leader>pw来查看当前文档的中的关键词的帮助文档
let g:pydoc_cmd="/usr/bin/pydoc"
"let g:pydoc_highlight=0 //是否要取消高亮

"pylint.vim
autocmd FileType python compiler pylint

"不要在每次buffer保存时调用Pylint
let g:pylint_onwrite = 0
"不要显示代码等级
let g:pylint_show_rate = 0
"不要显示QuickFix窗口
let g:pylint_cwindow = 0



""""""""""""""""""""""""""""""Taglist"""""""""""""""""""""
"在状态栏显示函数名
let g:ctags_statusline=1
"自动开启脚本
let generate_tag=1
"垂直显示
let Tlist_Use_Horiz_Window=0
"快捷键
nnoremap TT :TlistToggle<CR>
map <F4> :TlistToggle<CR>
"其他设置
let Tlist_Use_Left_Window=1
let Tlist_Show_One_File=0
"如果taglist自己是最后一个窗口，则退出vim
let Tlist_Exit_OnlyWindow=1
let Tlist_Compact_Format=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_File_Fold_Auto_Close=1
"这是键映射统一统计
"F5编辑当前文件
"F4打开一个TList
"map <F5> :e .<CR> 

"'''''''''''''''''''''''''''winManager设定''''''''''''''''''
let g:winManagerWindowLayout = "FileExplorer|TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 0
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap wm :WMToggle<cr>
"cscope 
set cscopequickfix=s-,c-,d-,i-,t-,e-
nmap <c-_>s :cs find s <c-r>=expand("<cword>")<cr><cr>
nmap <c-_>g :cs find g <c-r>=expand("<cword>")<cr><cr>
nmap <c-_>c :cs find c <c-r>=expand("<cword>")<cr><cr>
nmap <c-_>t :cs find t <c-r>=expand("<cword>")<cr><cr>
nmap <c-_>e :cs find e <c-r>=expand("<cword>")<cr><cr>
nmap <c-_>f :cs find f <c-r>=expand("<cfile>")<cr><cr>
nmap <c-_>i :cs find i ^<c-r>=expand("<cfile>")<cr><cr>
nmap <c-_>d :cs find d <c-r>=expand("<cword>")<cr><cr>
"quickfix
nmap <f6> :cn<cr>
nmap <f7> :cp<cr>

"'''''''''''''''''''''''''''''''''MinbufExploer设定
"ctrl+tab shift+ctrl+tab切换缓冲区里的文件
"设定和vim一样的移动方式
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapCTabSwitchWindows = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
"设置',t'交替出现minibuffer窗口
map <leader>t :TMiniBufExplorer<cr>     
command! BcloseOthers call <SID>BufCloseOthers()  
    function! <SID>BufCloseOthers()  
       let l:currentBufNum   = bufnr("%")  
       let l:alternateBufNum = bufnr("#")  
       for i in range(1,bufnr("$"))  
         if buflisted(i)  
           if i!=l:currentBufNum  
             execute("bdelete ".i)  
           endif  
         endif  
       endfor  
    endfunction  
map <leader>bdo :BcloseOthers<cr>  


"''''''''''''''''''''''''''''''cscope'''''''''''
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=1
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endif
set cscopequickfix=s-,c-,d-,i-,t-,e-
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"'''''''''''''''''''''''quickfix''''''''''''''''
nmap <F6> :cn<cr>
nmap <F7> :cp<cr>

"c++补全
set nocp
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Add highlighting for function definition in C++
function! EnhanceCppSyntax()
  syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
  hi def link cppFuncDef Special
endfunction

autocmd Syntax cpp call EnhanceCppSyntax()
""""""""""""""VimWiki""""""""""""""""""""""""""""""""""
"全局保存
let g:vimwiki_use_mouse = 1
"是否在保存词条文件时自动输出html
let g:vimwiki_list = [{'auto_export':0,
                       \'path':'/var/www/vimwiki/',
                       \'path_html':'/var/www/vimwiki/html/',
                       \'html_header':'vimwiki/template/header.tpl',
                       \'css_name':'css/style.css',
                       \}]
"对中文用户来说，我们并不怎么需要驼峰英文成为维基词条
let g:vimwiki_camel_case = 1
"是否在计算字串长度时用特别考虑中文字符
let g:vimwiki_CJK_length = 1
" 标记为完成的 checklist 项目会有特别的颜色
let g:vimwiki_hl_cb_checked = 1
" 我的 vim 是没有菜单的，加一个 vimwiki 菜单项也没有意义
let g:vimwiki_menu = ''
" 是否开启按语法折叠  会让文件比较慢
"let g:vimwiki_folding = 1
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'
"设置快捷键
map <F12> :VimwikiAll2HTML<cr>
