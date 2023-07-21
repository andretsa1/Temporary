set nocompatible
set pastetoggle=<F9>
set backspace=indent,eol,start
set history=50
set ruler
set showcmd
set incsearch
set nobackup
set nowb
set noswapfile
set ttyfast
set enc=utf-8
autocmd BufRead COMMIT_EDITMSG set spell
" indenting
set expandtab
set sw=4
set smarttab
set noautoindent                " replace autoindent with cindent
set cindent
set cinoptions=>4,e0,n0,f0,{0,}0,^0,:0,=4,l1,b0,g4,h0,p4,t4,i4,+4,c3,C0,/0,(24,u4,U0,w0,W0,m0,j0,)20,*30
"set cinoptions=+8
set formatoptions=tcqlron
set guifont=Consolas\ 10
set ic
"set scrolloff=999

if $HOST_TYPE=="SunOS"
    set nolpl
endif

if $HOST_TYPE=="Linux"
    filetype plugin on
    filetype indent on
endif

map Q gq

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
    "let g:zenburn_alternate_Visual = 1
    "colorscheme zenburn
endif

if has("autocmd")
    autocmd FileType text setlocal textwidth=78
"    autocmd BufEnter *.c,*.h,*.cpp,*.hpp,*.cc source ~/.vim/c.vim
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif

"   Logcat
    au BufRead,BufNewFile *.logcat set filetype=logcat
   " autocmd syntax * SpaceHi
endif " has("autocmd")

imap <S-Insert> <ESC>"*gP<CR>
set t_Co=256
"autocmd VimLeave * :set term=screen


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Scratch Buffer
function! ToggleScratch()
  if expand('%') == g:ScratchBufferName
    quit
  else
    Sscratch
  endif
endfunction

map <leader>s :call ToggleScratch()<CR>
map <leader>q :cclose<CR>
map <C-x> :cclose<CR> :bd<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"NERDTree
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Fuzzy Finder
map <leader>t :FufFileWithFullCwd<CR>
map <leader>b :FufBuffer<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Whitespace highlighting
map <leader>h :ToggleSpaceHi<CR>
let g:spacehi_spacecolor= "ctermbg=120 guibg=#87ff87"
let g:spacehi_tabcolor  = "ctermbg=150 guibg=#ff00d7"

" Enable fancy % matching
if has("eval")
    runtime! macros/matchit.vim
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set Android tags
set tags=./tags;$ANDROID_DIR
"set tags+=/local1/mnt/workspace/tags/android.ctags

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Tie cscope db
set nocsverb
if filereadable("cscope.out")
else
    if $ANDROID_BUILD_TOP !=""
        cscope add $ANDROID_BUILD_TOP/cscope.out
    else
        cscope add $ANDROID_DIR/cscope.out
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For python Execute file being edited with <Shift> + e:
"map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Multiple Highlight
let g:MultipleSearchColorSequence = "red,blue,green,magenta,cyan,gray,brown"
let g:MultipleSearchTextColorSequence = "black,black,black,black,white,black,black,white"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Status line
hi StatusLine term=underline ctermfg=Gray ctermbg=Black guifg=#40ffff guibg=#0000aa
hi User1 term=underline ctermfg=Black ctermbg=LightBlue guifg=#40ffff guibg=#0000aa
"set statusline=%1*%F%m%r%h%w%=%(%c%V\ %l/%L\ %P%)\ %{fugitive#statusline()}
set statusline=%1*%F%m%r%h%w%=%(%c%V\ %l/%L\ %P%)
let g:buftabs_in_statusline=1
let g:buftabs_active_highlight_group="User1"
let g:buftabs_only_basename=1
set laststatus=2
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Highlight long lines
highlight OverLength ctermbg=white ctermfg=red guibg=#592929
match OverLength /\%81v.\+/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Forgot Sudo ?
cmap w!! %!sudo tee > /dev/null %
"nmap <silent> <Leader>cd :cd %:p:h<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Gtags
"map <C-]> <esc>:Gtags <CR><CR>
map <leader>gg <esc>:Gtags <CR><CR>
map <leader>gr <esc>:Gtags -r<CR><CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Buffer maps
nmap gb :bnext<CR>
nmap gB :bprev<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"yankring
let g:yankring_history_dir="~/.tmp"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch buffers
nnoremap <Leader>1 :b1<CR>
nnoremap <Leader>2 :b2<CR>
nnoremap <Leader>3 :b3<CR>
nnoremap <Leader>4 :b4<CR>
nnoremap <Leader>5 :b5<CR>
nnoremap <Leader>6 :b6<CR>
nnoremap <Leader>7 :b7<CR>
nnoremap <Leader>8 :b8<CR>
nnoremap <Leader>9 :b9<CR>
nnoremap <Leader>0 :b10<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
set textwidth=80
