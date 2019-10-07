
alias gb='for k in `git branch|perl -pe s/^..//`;do echo -e `git show --pretty=format:"%Cblue%cr%Creset" $k|head -n 1`\\t$k;done'
alias migrate="bundle exec rake db:migrate db:test:prepare"
alias be="bundle exec"
alias bake="bundle exec rake"
alias ql="qlmanage -p"
alias macvim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias vi="nvim" # I'm lazy
alias mux="tmuxinator"

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
# alias ag="ag --color-line-number=33 --color-path=32"
