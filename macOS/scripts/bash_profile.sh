PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${HOME}/bin
export PATH

alias gcbp='gradle clean build publishToMavenLocal -x test'
alias pdserv='php -S localhost:8080 -t '
alias python='python3'
alias pip='pip3'
alias resetFileGit='git checkout HEAD -- '
alias simpleWS='python3 -m http.server 8000'
alias undoLastCommit='git reset --soft HEAD~1'
alias whatIsMyIP='curl icanhazip.com'
alias ytAudio='youtube-dl -i -w -f bestaudio -x --audio-format m4a --audio-quality 0 --add-metadata '