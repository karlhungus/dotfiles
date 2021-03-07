"" Plugins
let g:vim_markdown_folding_disabled = 1

"" Emmet
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key     = "<C-X>"

" FZF
map <leader>t :FZF<CR>
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

" search buffers
nnoremap <silent> <Leader>b :call fzf#run({
      \   'source':  reverse(<sid>buflist()),
      \   'sink':    function('<sid>bufopen'),
      \   'options': '+m',
      \   'down':    len(<sid>buflist()) + 2
      \ })<CR>

" search in files
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nnoremap <C-p>a :Rg
nnoremap <silent> <Leader>r :Rg<CR>

" NERDTree
"let g:NERDSpaceDelims=1
"let g:NERDTreeIgnore=["__pycache__", "\.egg-info"]

" airline
let g:airline_powerline_fonts              = 1
let g:airline_section_z                    = airline#section#create_right(["%l/%L"])
let g:airline#extensions#ale#enabled = 1
let g:airline_theme                        = "badwolf"

" ale
"let g:ale_lint_on_enter            = 0 " don't lint when opening a file
"let g:ale_fix_on_save              = 1 " lint/correct on save
"let g:ale_sign_column_always       = 1 " keep the column open all the time
"let g:ale_lint_on_text_change      = "normal" " lint on update
"let g:ale_linters = {
"      \ 'go': ['gopls'],
"      \ }
"let g:ale_linters = {
"     \  'go': ['gofmt', 'goimports', 'go vet', 'golint', 'gometalinter', 'go build', 'gosimple', 'staticcheck'],
"      \ }

" vim-go
"let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

augroup LspGo
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'go-lang',
      \ 'cmd': {server_info->['gopls']},
      \ 'whitelist': ['go'],
      \ })
  autocmd FileType go setlocal omnifunc=lsp#complete
  "autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
  "autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
  "autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
augroup END

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

call asyncomplete#register_source(asyncomplete#sources#gocode#get_source_options({
    \ 'name': 'gocode',
    \ 'allowlist': ['go'],
    \ 'completor': function('asyncomplete#sources#gocode#completor'),
    \ 'config': {
    \    'gocode_path': expand('~/go/bin/gocode')
    \  },
    \ }))

if executable('gopls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls']},
        \ 'allowlist': ['golang'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" rust auto-format on save
let g:rustfmt_autosave = 1

" vim-ruby
let g:ruby_indent_assignment_style = 'variable'

" You complete me
"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion = ['<Up>']
"let g:ycm_show_diagnostics_ui = 1
"let g:ycm_enable_diagnostic_highlighting = 1

" Integrate YouCompleteMe with vim-multiple-cursors, otherwise
" the numerous Cursor events cause great slowness
" (https://github.com/kristijanhusak/vim-multiple-cursors/issues/4)
"function Multiple_cursors_before()
"  let s:old_ycm_whitelist = g:ycm_filetype_whitelist
"  let g:ycm_filetype_whitelist = {}
"endfunction

"function Multiple_cursors_after()
"  let g:ycm_filetype_whitelist = s:old_ycm_whitelist
"endfunction

" localvimrc
let g:localvimrc_ask     = 0
let g:localvimrc_sandbox = 0

" Treat these tags like the block tags they are
let g:html_indent_tags = 'li\|p\|header\|footer\|section\|aside\|nav'

" use ag if available
if executable("ag")
  let g:ackprg = "ag --nogroup --column"
endif

" use rg if available
if executable("rg")
  let g:ackprg = "rg --vimgrep --no-heading"
endif

" scala
let g:scala_scaladoc_indent = 1
