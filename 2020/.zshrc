#meta stuff
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
zstyle :compinstall filename '/home/desu/.zshrc'

#aliases
alias cp='cp -iv'
alias grep='grep --color=auto'
alias fucking='sudo'
alias v='nvim'
alias sv='sudo nvim'
alias pi='sudo pacman -S'
alias csl='sudo ln -s'
alias ls='ls --color=auto'
alias lsa='ls -A --color=auto'
alias todo="cat ~/todo"
alias ux='xrdb .Xresources'
alias zshrc='nvim ~/.zshrc'
alias i3c='nvim ~/.config/i3/config'
alias vimrc='nvim ~/.vimrc'
alias wm='networkmanager_dmenu'
alias nettest='ping 8.8.8.8'
alias setwp='feh --bg-fill'
alias ccpp='g++ -std=gnu++0x'

alias cterm='ps -aux | grep `ps -p $$ -o ppid=` '
alias wfl="nmcli device wifi list"
alias wfc="nmcli device wifi connect"
alias utime='sudo ntpd -qg; sudo hwclock -w'
alias stopwatch='date1=`date +%s`; while true; do 
   echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
done'
alias mictest='arecord --duration=5 --format=dat test-mic.wav &&sleep 0.5 && aplay test-mic.wav && rm -rf test-mic.wav'
alias img='feh $(ls -A | grep -e jpg -e png -e gif| rofi -dmenu)'
alias typora='~/tmp/typora/Typora-linux-x64/Typora'
alias killmpd='sudo kill -9 $(sudo ps -A | grep mpd | cut -f 1 -d " ")'
alias uwu='curl "https://corona-stats.online/?source=2"'

# unrar to new directory w/ name of archive filename
function ur() {
    archive=$(echo $1 | rev | cut -c 5- | rev)
    mkdir $archive
    mv $1 $archive
    cd $archive
    unrar e $1
    cd ..

}
# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
comp_options+=(globdots)
PROMPT='%F{6}%n%f@%F{5}%m%f %F{4}%~%f>'
#functions
function countdown(){
   date1=$((`date +%s` + $1));
   while [ "$date1" -ge `date +%s` ]; do
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
}
function random()
{
	echo -e "$(shuf -i 1-$1 -n 1)"
}
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'
# line cursor
printf '\033[5 q\r'
#source /home/comfy/tmp/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
