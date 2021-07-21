# bash completions
[[ -r '/usr/local/etc/profile.d/bash_completion.sh' ]] && . '/usr/local/etc/profile.d/bash_completion.sh'

# configure path
eval $($([ -f '/opt/homebrew/bin/brew' ] && printf '/opt/homebrew/bin/brew' || printf '/usr/local/bin/brew') shellenv)
export PATH="${HOME}/bin:${PATH}"

# for d in "${HOME}/bin" "/opt/homebrew/sbin" "/opt/homebrew/bin"; do
# 	if [ -d "$d" ]; then
# 		export PATH="${d}:${PATH}"
# 	fi
# done

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