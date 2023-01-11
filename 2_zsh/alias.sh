#/bin/zsh
alias d='dirs -v'
for index ({0..9}) alias "$index"="cd +${index}"; unset index
