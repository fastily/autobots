# bash completions
[[ -r '/usr/local/etc/profile.d/bash_completion.sh' ]] && . '/usr/local/etc/profile.d/bash_completion.sh'

# configure path
[ "$(uname -m)" == "arm64" ] && my_brew="/opt/homebrew/bin/brew" || my_brew="/usr/local/bin/brew"
if [ -f "$my_brew" ]; then
	eval $("$my_brew" shellenv)
fi

export PATH="${HOME}/bin:${PATH}"

# aliases
alias b64d='base64 -D -i '
alias b64e='base64 -i '
alias buu='brew update && brew upgrade'
alias drs='python3 manage.py runserver'
alias ffprobe='ffprobe -hide_banner '
# alias gcp='gradle clean publishToMavenLocal -x test'
alias nrd='npm run dev'
alias pdserv='php -S localhost:8080 -t '
alias python='python3'
alias pip='pip3'
alias po='pip3 list --outdated '
alias pu='pip3 install --upgrade '
alias resetFileGit='git checkout HEAD -- '
alias simpleWS='python3 -m http.server 8000'
alias undoLastCommit='git reset --soft HEAD~1'
alias whatIsMyIP='curl icanhazip.com'
alias ytAudio='youtube-dl -i -w -f bestaudio --add-metadata '


# local settings
bash_local=~/".bash_local"
if [ -f "$bash_local" ]; then
	source "$bash_local"
fi