# Profileing
# zmodload zsh/zprof
# Path to your oh-my-zsh configuration.
ZSH="${HOME}/.oh-my-zsh"
ZSH_CUSTOM="${HOME}/.zshrc.d/custom"
#ZSH_THEME="crunch"
ZSH_THEME="izaak-crunch"
plugins=(history-substring-search fasd git osx ruby bundler brew golang kubectl)
source $ZSH/oh-my-zsh.sh

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

source /usr/local/opt/chruby/share/chruby/chruby.sh

# Allow [ or ] wherever you want
unsetopt nomatch

fpath=("${HOME}/.zshrc.d/completion" $fpath)
#plugins=(fasd osx gitfast history-substring-search knife)

# source "${ZSH}/oh-my-zsh.sh"

source "${HOME}/.shellrc"

if [[ $OSTYPE == darwin* ]]; then
  /usr/local/bin/fortune smac
fi
if [[ $OSTYPE == linux* ]]; then
  /usr/games/fortune smac
fi

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.yarn/bin:$PATH"


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/ialpert/bin/vault vault

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
