#meta stuff
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
zstyle :compinstall filename '/home/desu/.zshrc'
#aliases
alias pi='sudo pacman -S'
alias ls='ls --color=auto'
alias lsa='ls -A --color=auto'
alias todo="cat ~/todo"
alias ux='xrdb .Xresources'
alias melee='apulse ./Downloads/launch-fm'
alias zshrc='vim ~/.zshrc'
alias i3c='vim ~/.config/i3/config'
alias vimrc='vim ~/.vimrc'
alias wm='networkmanager_dmenu'
alias nettest='ping 8.8.8.8'
alias spotify='snap run spotify'
alias setwp='feh --bg-scale'
#smaller aliases that work as "scripts"
alias cterm='ps -aux | grep `ps -p $$ -o ppid=` '
alias wfl="nmcli device wifi list"
alias wfc="nmcli device wifi connect"
alias utime='sudo ntpd -qg; sudo hwclock -w'
alias stopwatch='date1=`date +%s`; while true; do 
   echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
done'
alias mictest='arecord --duration=5 --format=dat test-mic.wav &&sleep 0.1 && aplay test-mic.wav && rm -rf test-mic.wav'
alias img='feh $(ls -A | grep -e jpg -e png -e gif| dmenu)'
autoload -Uz compinit
compinit
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
