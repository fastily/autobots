PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${HOME}/bin
export PATH

alias b64d='base64 -D -i '
alias b64e='base64 -i '
alias drs='python3 manage.py runserver'
alias ffprobe='ffprobe -hide_banner '
alias gcbp='gradle clean build publishToMavenLocal -x test'
alias nrd='npm run dev'
alias pdserv='php -S localhost:8080 -t '
alias python='python3'
alias pip='pip3'
alias resetFileGit='git checkout HEAD -- '
alias simpleWS='python3 -m http.server 8000'
alias undoLastCommit='git reset --soft HEAD~1'
alias whatIsMyIP='curl icanhazip.com'
alias ytAudio='youtube-dl -i -w -f "bestaudio[ext=m4a]/bestaudio" --add-metadata '