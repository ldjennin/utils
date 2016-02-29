set -o vi

ssh-add
function yt-mp3() { youtube-dl --title  --extract-audio --audio-quality 0 --audio-format mp3 "$@" ;}
function yt() { youtube-dl --title "$@" ;}

export NVM_DIR="/home/osboxes/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export HISTCONTROL=erasedups
export HISTSIZE=10000
