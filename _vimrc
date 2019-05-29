"==========================================================================
" 1. 初始配置
"==========================================================================

" 关闭兼容模式，使能扩展功能，加在所有配置之前，保证后续扩展的正确性
set nocompatible

" 关闭自动备份
set nobackup


" source以及behave配置
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

" 快捷键配置为windows模式
behave mswin

"==========================================================================
" 2. 操作系统以及VIM终端检测
"==========================================================================

let g:iswindows = 0
let g:islinux = 0

if(has("win32") || has(win64) || has(win95) || has(win16))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

"==========================================================================
" 3. 默认配置
"==========================================================================

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"==========================================================================
" 4. Vundle插件管理
"==========================================================================

" Vundle configuration
filetype off                  " required，禁用文件类型检测

" set the runtime path to include Vundle and initialize
set rtp+=$VIM/vimfiles/Vundle.vim
" call vundle#begin('$VIM/vimfiles/plugin')
call vundle#begin('d:/Github/VIM_IDE/vimfiles/plugin')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" NerdTree install and configuration
Plugin 'scrooloose/nerdtree'



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" 使用F2进行插件调用
nmap <F2> :NERDTreeToggle<CR>


"==========================================================================
" 5. 格式以及编码配置
"==========================================================================

"--------------------------------------------------------------------------
" 5.1 编码配置
"--------------------------------------------------------------------------


"--------------------------------------------------------------------------
" 5.2 格式配置
"--------------------------------------------------------------------------

" 智能对齐
set smartindent

" Tab键设置 : 可以转换为空格 转换空格宽度为4
set expandtab
set tabstop=4
" 缩进设置 删除键删除对应sw宽度
set shiftwidth=4
set smarttab

"==========================================================================
" 6. 命令map配置
"==========================================================================


"==========================================================================
" 7. 显示配置
"==========================================================================

" 基本显示
set number "显示行号
set laststatus=2 "启用状态栏信息
set guifont=courier_new:h10

" 菜单显示 ：菜单栏，工具栏 滚动条的隐藏/显示切换，可用ctrl + F11进行切换

if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    nmap <silent> <c-F11> :if $guioptions =~ 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif




" color silarized setting
syntax enable
set background=dark
colorscheme solarized
