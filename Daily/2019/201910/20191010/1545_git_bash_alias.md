## git bash alias

配置文件~/.bash_profile

``` shell
alias ga='git add -A'
alias gm='function _gitcommit(){ git commit -am "$*" ; };_gitcommit'
alias gp='git push origin master'
alias gs='git status'
alias ll='ls -al'
```

