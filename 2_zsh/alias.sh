#/bin/zsh
alias d='dirs -v'
for index ({0..9}) alias "$index"="cd +${index}"; unset index
alias cp='cp -i -v'
alias mv='mv -i -v'
alias rm='rm -i -v'
