PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${HOME}/bin
export PATH

alias ddss="find . -name '*.DS_Store' -type f -delete"
alias gcbp='gradle clean build publishToMavenLocal -x test'
alias pdserv='php -S localhost:8080 -t '
alias resetFileGit='git checkout HEAD -- '
alias undoLastCommit='git reset --soft HEAD~1'
alias ytAudio='youtube-dl -i -w -f bestaudio -x --audio-format m4a --audio-quality 0 --add-metadata '