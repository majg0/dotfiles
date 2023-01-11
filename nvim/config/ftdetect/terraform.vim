" TODO: nvim-tree does not get correct icon.
augroup filetypedetect
  autocmd BufNew,BufNewFile,BufRead *.tf,*.tfvars :setfiletype terraform
augroup END
