# Easy Navigation
alias triple="cd ~/triple"
alias assets="cd ~/triple/triple-web-assets"
alias tna="cd ~/triple/tna-web-v2"
alias air="cd ~/triple/triple-air-web"
alias hotel="cd ~/triple/triple-hotels-web"
alias content="cd ~/triple/triple-content-web"
alias booking="cd ~/triple/my-bookings-web"
alias intro="cd ~/triple/triple-intro-web"
alias corp="cd ~/triple/corp-web"
alias search="cd ~/triple/triple-search-web"
alias offerwall="cd ~/triple/triple-offerwall-web"
alias cash="cd ~/triple/triple-cash-web"
alias chat="cd ~/triple/triple-chat-web"
alias benefit="cd ~/triple/triple-benefit-web"
alias mileage="cd ~/triple/triple-mileage-web-v2"
alias genie="cd ~/triple/triple-genie-web"
alias tf="cd ~/triple/triple-frontend"
alias benefit="cd ~/triple/triple-benefit-web"

#about terminal
alias c='clear'
alias r='reset'
alias cat="bat"
alias del="rm -rf"

# Tools
alias ow="webstorm ."

# Utilities
alias f="open -a Finder"
alias ll='ls -lFh'
alias la='ls -AlFh'
alias l='ls -CF'
alias l.='ls -d .* --color=auto'

# NODE & BOWER
alias nrd="npm run dev"
alias ni="npm install"
alias nig="npm install -g"
alias nis="npm install --save"
alias nisd="npm install --save-dev"
alias nu="npm update"
alias bi="bower install"

# Setting
alias oba="open ~/.bash_aliases"
alias sba="source ~/.bash_aliases"
alias ozr="open ~/.zshrc"
alias szr="source ~/.zshrc"

# Etc
alias up='[ $(git rev-parse --show-toplevel 2>/dev/null || echo ~) = $(pwd) ] && cd $([ $(echo ~) = $(pwd) ] && echo / || echo) || cd $(git rev-parse --show-toplevel 2>/dev/null)'

function topcmds() {
  [ ! -z $1 ] && n="$1" || n="10"
  history | awk '{a[$2 " " $3]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -n $n
}

# Git
# http://blog.tdg5.com/sixty-bash-tastic-git-aliases/
alias g='git'
alias gcl='git clone'
alias gget='git pull'
alias gput='git push'
alias gputo='git push origin'
alias gs='git status'
alias gsh='git show'
alias gbr='git branch'
alias gbrc='git rev-parse --abbrev-ref HEAD'
alias gbrp='git reflog | sed -n "s/.*checkout: moving from .* to \(.*\)/\1/p" | sed "2q;d"'
alias gbrb="git checkout -"
alias gst='git stash'
alias gss='git stash save'
alias gsa='git stash apply'
alias gsl='git stash list'
alias gsp='git stash pop'
alias gssh='git stash show -p'
alias gssh='git stash show --name-only'
alias gsd='git stash drop'
alias gg='git grep'
alias ggi='git grep -i'
alias ggno='git grep --name-only'
alias grb='git rebase'
alias grbi='git rebase --interactive'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'
alias grbm='git rebase master'
alias gcm='git commit'
alias gcmm='git commit -m'
alias gcmv='git commit -v'
alias gamd='git commit --amend --no-edit'
alias gamend='git commit --amend'
alias gcp='git cherry-pick'
alias gm='git merge'
alias gmm='git merge master'
alias ga='git add'
alias gaa='git add -A'
alias gap='git add -p'
alias gau='git add -u'
alias grh='git reset HEAD'
alias gback='git reset --soft HEAD~'
alias gbackk='git reset HEAD~ --hard'
# alias gco='git checkout'
alias gcoa='git checkout .'
alias gcob='git checkout -b'
alias gsw='git switch'
alias gswn='git switch -c'
alias gl='git log'
alias glp='git log -p'
alias gls='git log --oneline'
alias glv='git log --oneline --graph'
alias gd='git diff'
alias gds='git diff --staged'
alias gtagl="git tag -l"
alias gtagd="git tag -d"

alias gb="fzf-git-branch"
alias gco="fzf-git-checkout"

function gshn() {
  ([ -z "$1" ] || [ $(($1)) -lt 0 ]) && echo 'Invalid integer!' && return
  git show HEAD@{$1}
}

GBRR_DEFAULT_COUNT=10
function gbrr() {
  COUNT=${1-$GBRR_DEFAULT_COUNT}

  IFS=$'\r\n' BRANCHES=($(
    git reflog | \
    sed -n 's/.*checkout: moving from .* to \(.*\)/\1/p' | \
    perl -ne 'print unless $a{$_}++' | \
    head -n $COUNT
  ))

  for ((i = 0; i < ${#BRANCHES[@]}; i++)); do
    echo "$i) ${BRANCHES[$i]}"
  done

  read -p "Switch to which branch? "
  if [[ $REPLY != "" ]] && [[ ${BRANCHES[$REPLY]} != "" ]]; then
    echo
    git checkout ${BRANCHES[$REPLY]}
  else
    echo Aborted.
  fi
}

function ggo() {
  $EDITOR $(git grep --name-only "$@")
}

function ggio() {
  $EDITOR $(git grep -i --name-only "$@")
}

function grbp() {
  br="$(git reflog | sed -n 's/.*checkout: moving from .* to \(.*\)/\1/p' | sed "2q;d")"
  git rebase $br
}

function gmp() {
  br="$(git reflog | sed -n 's/.*checkout: moving from .* to \(.*\)/\1/p' | sed "2q;d")"
  git merge $br
}

function gtaga() {
  [ -z "$1" ] && echo 'Invalid tag name!' && return
  [ -z "$2" ] && msg="$1" || msg="$2"
  git tag -a $1 -m $msg
}

function gtagdr() {
  [ -z "$1" ] && echo 'Invalid tag name!' && return
  git push origin :refs/tags/$1
}

function gputu() {
  if [ -z "$1" ]; then
    br="$(git rev-parse --abbrev-ref HEAD)"
  else
    br="$1"
  fi
  git push -u origin $br
}

function gcopr() {
  ([ -z "$1" ] || [ $(($1)) -le 0 ]) && echo 'Invalid pull request ID' && return
  pr_id=$1
  [ -z "$2" ] && br_name="pull_request_${1}" || br_name="$2"
  git fetch origin pull/${pr_id}/head:${br_name}
  git checkout ${br_name}
}

function fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}

function fzf-git-checkout() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(fzf-git-branch)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}
