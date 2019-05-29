"==========================================================================
" 1. ��ʼ����
"==========================================================================

" �رռ���ģʽ��ʹ����չ���ܣ�������������֮ǰ����֤������չ����ȷ��
set nocompatible

" �ر��Զ�����
set nobackup


" source�Լ�behave����
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

" ��ݼ�����Ϊwindowsģʽ
behave mswin

"==========================================================================
" 2. ����ϵͳ�Լ�VIM�ն˼��
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
" 3. Ĭ������
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
" 4. Vundle�������
"==========================================================================

" Vundle configuration
filetype off                  " required�������ļ����ͼ��

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

" ʹ��F2���в������
nmap <F2> :NERDTreeToggle<CR>


"==========================================================================
" 5. ��ʽ�Լ���������
"==========================================================================

"--------------------------------------------------------------------------
" 5.1 ��������
"--------------------------------------------------------------------------


"--------------------------------------------------------------------------
" 5.2 ��ʽ����
"--------------------------------------------------------------------------

" ���ܶ���
set smartindent

" Tab������ : ����ת��Ϊ�ո� ת���ո���Ϊ4
set expandtab
set tabstop=4
" �������� ɾ����ɾ����Ӧsw���
set shiftwidth=4
set smarttab

"==========================================================================
" 6. ����map����
"==========================================================================


"==========================================================================
" 7. ��ʾ����
"==========================================================================

" ������ʾ
set number "��ʾ�к�
set laststatus=2 "����״̬����Ϣ
set guifont=courier_new:h10

" �˵���ʾ ���˵����������� ������������/��ʾ�л�������ctrl + F11�����л�

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
