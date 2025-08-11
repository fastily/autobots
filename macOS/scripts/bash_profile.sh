[[ -r "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="${HOME}/bin:${PATH}"

# aliases
alias b64d='base64 -D -i '
alias b64e='base64 -i '
alias buu='brew update && brew upgrade'
alias buuu='buu && brew upgrade --cask -g'
# alias clean_py_build='rm -rfv build dist *.egg-info'
# alias drs='python3 manage.py runserver'
alias ffprobe='ffprobe -hide_banner '
# alias gcp='gradle clean publishToMavenLocal -x test'
# alias nrd='npm run dev'
alias python='python3'
alias pdb='uv sync -U --no-install-project'
alias pie='pip3 install --config-settings editable_mode=compat -e '
alias po='uv pip list -o'
alias resetFileGit='git checkout HEAD -- '
alias tar='gtar'
alias ucc='uv cache clean'
alias undoLastCommit='git reset --soft HEAD~1'
alias weather='curl https://wttr.in'
alias whatIsMyIP='curl https://icanhazip.com'
alias youtube_audio='yt-dlp -w -f bestaudio --add-metadata '


# local settings
for s in "local" "keys"; do
    [[ -r ~/".bash_${s}" ]] && . ~/".bash_${s}"
done
