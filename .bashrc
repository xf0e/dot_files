umask 077
#export LIBVA_DRIVER_NAME=vdpau
############################
### NON INTERACTIVE MODE ###
############################

[ -z "$PS1" ] && return
if [[ $- != *i* ]] ; then
         return
fi

[[ -f /etc/bash_completion ]] && . /etc/bash_completion

if [ -f ~/.dircolors ]; then
           eval `dircolors ~/.dircolors`
fi

#############################
### Environment Variables ###
#############################
TERM=xterm-256color
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export EDITOR=vim
export HISTIGNORE="&:ls:[bf]g:exit:bash:[cxh]:a\ "
export HISTCONTROL=ignoreboth
export BROWSER=firefox
export MANPAGER=vimpager
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \'
export PAGER=/usr/bin/vimpager

#####################
### Shell Options ###
#####################

shopt -s mailwarn
shopt -s autocd
shopt -s cmdhist
shopt -s expand_aliases
shopt -s extglob
shopt -s no_empty_cmd_completion
shopt -s nocaseglob
shopt -s checkwinsize
shopt -s cdspell
shopt -s histappend
shopt -s dotglob
shopt -s globstar
shopt -s dirspell

[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"
LOCALHOST='cassiopeia'

### INTERACTIVE MODE ###

##############
### Colors ###
##############
export color_N=$(tput sgr0)                 # Normal
export color_F=$(tput blink)                # Blink

### Standard text ###
export color_L=$(tput sgr0; tput setaf 0)   # Black
export color_R=$(tput sgr0; tput setaf 1)   # Red
export color_G=$(tput sgr0; tput setaf 2)   # Green
export color_Y=$(tput sgr0; tput setaf 3)   # Yellow
export color_B=$(tput sgr0; tput setaf 4)   # Blue
export color_P=$(tput sgr0; tput setaf 5)   # Magenta
export color_C=$(tput sgr0; tput setaf 6)   # Cyan
export color_W=$(tput sgr0; tput setaf 7)   # White

### Bold text ###
export color_l=$(tput bold ; tput setaf 0)  # Black
export color_r=$(tput bold ; tput setaf 1)  # Red
export color_g=$(tput bold ; tput setaf 2)  # Green
export color_y=$(tput bold ; tput setaf 3)  # Yellow
export color_b=$(tput bold ; tput setaf 4)  # Blue
export color_p=$(tput bold ; tput setaf 5)  # Magenta
export color_c=$(tput bold ; tput setaf 6)  # Cyan
export color_w=$(tput bold ; tput setaf 7)  # White

### Background ###
export color_LB=$(tput sgr0; tput setab 0)  # Black
export color_RB=$(tput sgr0; tput setab 1)  # Red
export color_GB=$(tput sgr0; tput setab 2)  # Green
export color_YB=$(tput sgr0; tput setab 3)  # Yellow
export color_BB=$(tput sgr0; tput setab 4)  # Blue
export color_PB=$(tput sgr0; tput setab 5)  # Magena
export color_CB=$(tput sgr0; tput setab 6)  # Cyan
export color_WB=$(tput sgr0; tput setab 7)  # White


##############
### Prompt ###
##############

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\]\342\224\214\342\224\200[\$(smiley)][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\\W \[$(tput setaf 3)\]- $(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, $(/bin/ls -lah `pwd`| /usr/bin/head -n 1)b\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\n\[$(tput setaf 1)\]\342\224\224\342\224\200\342\224\200\342\224\200\342\225\274 \[$(tput sgr0)\]"

#########################
### Aliases/Functions ###
#########################

#alias rm="rm -i"
alias mc='mc -S modarin256'
alias less=${PAGER}
alias zless=${PAGER}
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -lh --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ncmpc='ncmpc -c'
alias mocp='mocp -T darkdot_theme '
alias ping='ping -c 5'
#alias aptinstall='sudo apt-get install'
#alias aptbuild-dep='sudo apt-get build-dep'
#alias aptsearch='aptitude search'
alias build='makepkg -fis'
alias upgrade='yaourt -Syu --aur'
alias update='yaourt -Sy'
# проверка правописания - настоятельно рекомендую :-)
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'
alias back='cd $OLDPWD'
alias music='mplayer -cache-min 0 $**.{mp3,flac,ogg}'
alias cd..='cd ..'
alias du='du -h -c'
alias mkdir='mkdir -p -v'
alias ..='cd ..'
alias duh='du -h --max-depth=1'
alias bones='grep -vE "^#|^$"'
alias make='make -j4'
#alias cp='wrap cp -iv'
#alias mv='wrap mv-iv'
#alias wget='wrap wget'
alias webshare='python2 -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'
alias futurama='curl -Is slashdot.org | egrep "^X-(F|B)" | cut -d \- -f 2'
alias grep="grep -i"
alias rtorrent='rtorrent -o http_capath=/etc/ssl/certs'
alias rehash='. ${HOME}/.bashrc'
alias perm='stat -c %a'
alias sedit='sudo ${EDITOR}'
alias diff='colordiff'
alias hist='history | grep $1'
alias openports='netstat --all --numeric --programs --inet'
alias releasemouse='xdotool mouseup 3'
alias dirf='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'

#########################
###System maintenance ###
#########################

function getWeather(){
    if [ $# = 0 ] ; then
        city="Halle(Saale), DE"
    else
        city=$1
    fi
    curl -s "http://api.openweathermap.org/data/2.5/forecast/daily?q=$city&units=metric&cnt=2" | \
        sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep 'main\|temp' |sed -e 's/[""]/''/g' | sed -e 's/main/''/g'
}


function cleanDependencies(){
  for i in $(pacman -Qdt | awk '{print $1}');
	do  echo $i ;
	sudo pacman -R $i;
  done;
}


function ebrc() {
    ${EDITOR} ~/.bashrc
    source ~/.bashrc
}

# Searches for package(s) in repos and ABS.
iterate () {
    if [[ -z "$1" ]]; then
        echo "Missing arguments.  Syntax: COMMAND [ARGS] ::: [ARGS]"
        return 1
    fi
    cmd="$1"
    shift
    for x in "$@"; do
        ${cmd//:::/$x}
    done
}

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1        ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       rar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xf $1        ;;
            *.tbz2)      tar xjf $1      ;;
            *.tgz)       tar xzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
pk () {
    if [ $1 ] ; then
        case $1 in
            tbz)       tar cjvf $2.tar.bz2 $2      ;;
            tgz)       tar czvf $2.tar.gz  $2       ;;
            tar)      tar cpvf $2.tar  $2       ;;
            bz2)    bzip $2 ;;
            gz)        gzip -c -9 -n $2 > $2.gz ;;
            zip)       zip -r $2.zip $2   ;;
            7z)        7z a $2.7z $2    ;;
            *)         echo "'$1' cannot be packed via pk()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

psgrep() {
        if [ ! -z $1 ] ; then
                echo "Grepping for processes matching $1..."
                ps aux | grep $1 | grep -v grep
        else
                echo "!! Need name to grep for"
        fi
}
bcalc() {
                echo "${1}"|bc -l;
}
fscp() {
                file="${1}"
                endfile=`echo $file | sed "s/\//\n /g" | sed "s/ //" |  tail -1`
                scp $file $2@$3:$4
                echo "http://$3/$endfile" | xclip -i -l 1

}

screenshot() {
                name=`date +%Y%m%I%M%S%N`
                file=$name.png
                scrot $file -e 'mv $f /home/lib/shots/' -d 5
                url="http://host/$file"
                echo "$url" | xclip -i -l 1
                scp /home/user/shots/$file user@host:/path/to/public_html
}

genpass()
{
    cat /dev/urandom | tr -d -c 'a-zA-Z0-9' | fold -w 8 | head -1
}

p_cpu() {
        ps -e -o pcpu,args --sort pcpu | sed '/^ 0.0 /d'
}

myip() {
        lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/
}



function to_iso () {
    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Converts raw, bin, cue, ccd, img, mdf, nrg cd/dvd image files to ISO image file. Usage ${RED_FG}'to_iso file1 file2...'$NC"
    fi
    for i in $*; do
        if [ ! -f "$i" ]; then
            echo "'$i' is not a valid file; jumping it"
        else
            echo -n "converting $i..."
            OUT=`echo $i | cut -d '.' -f 1`
            case $i in
            *.raw)              bchunk -v $i $OUT.iso;; #raw=bin #*.cue #*.bin
            *.bin|*.cue)        bin2iso $i $OUT.iso;;
            *.ccd|*.img)        ccd2iso $i $OUT.iso;; #Clone CD images
            *.mdf)              mdf2iso $i $OUT.iso;; #Alcohol images
            *.nrg)              nrg2iso $i $OUT.iso;; #nero images
            *)                  echo "to_iso don't know de extension of '$i'";;
            esac
            if [ $? != 0 ]; then
                echo -e "${RED_FG}ERROR!$NC"
            else
                echo -e "${GREEN_FG}done!$NC"
            fi
        fi
    done
}



function mount_iso () {
    local MOUNT_DIR=$HOME/mounted_iso

    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Mount ISO files in '$MOUNT_DIR' folder . Usage ${RED_FG}'mount_iso isofile'$NC"
        return
    fi

    mkdir $MOUNT_DIR
    echo "mount directory $MOUNT_DIR created, mounting image..."
    sudo mount -o loop -t iso9660 $1 $MOUNT_DIR

    if [ $? != 0 ]; then
        echo -e "${RED_FG}ERROR!$NC deleting $MOUNT_DIR"
        rm -rfv $MOUNT_DIR
    else
        echo -e "${GREEN_FG}done!$NC for unmount type 'umount $MOUNT_DIR'"
    fi
}

function rnm () {
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Rename file or folder. Changes in the name; spaces with '_', substrings ' - ' with '-', and delete non printable characters. Usage ${RED_FG}'rnm file'$NC or ${RED_FG}'rnm folder'$NC"
        return
    fi
    if [ ! -d "$1" ] && [ ! -f "$1" ]; then
        echo "'$1' is not a valid file or folder"
        return
    fi
    # first delete blank spaces using sed, later tr delete non printable characters
    local NEW=`echo $1 | sed s/' '/_/g | tr -cd '\11\12\40-\176'`
    # others adjust for best renaming
    NEW=`echo $NEW | sed s/'_-_'/-/g`
    mv "$1" $NEW
    echo "renamed as '$NEW'"
}


function rmtabs () {
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Remove the tabulators in files and replace each by 4 spaces. Usage ${RED_FG}'rmtabs file1 file2...'$NC"
        return
    fi

    for file in $*; do
        if [ -f "$file" ]; then
            sed s/'\t'/'    '/g < $file > modified
            mv modified $file
        else
            echo "'$file' is not a valid file; jumping it"
        fi
    done
}


function rmnpc () {
    if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Remove non printable characters from a files. Usage ${RED_FG}'rmnpc file1 file2...'$NC"
        return
    fi

    for file in $*; do
        if [ -f "$file" ]; then
            tr -cd '\11\12\40-\176' < $file > modified
            mv modified $file
        else
            echo "'$file' is not a valid file; jumping it"
        fi
    done
}


function my_ps () {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Shows all the process of the current user. Usage ${RED_FG}'my_ps'$NC or ${RED_FG}'my_ps process1 process2...'$NC"
        return
    fi
    ps $@ -u $USER -o stat,pid,%cpu,%mem,bsdtime,command ;
}

usage() {
        echo "Этот файл создан, чтобы упростить работу за компьютером";
        echo "Основные функции:";
        echo "extract ФАЙЛ - распаковка архива, скрипт сам выбирает чем распаковывать";
        echo "pk ТИП ФАЙЛ - упаковка архива, указываете тип(tbz, tgz, gz, tar, gz, bz2, zip, 7z)";
        echo "psgrep ИМЯ - поиск запущенного процесса ИМЯ ";
        echo "bcalc 2+2*2 - c помощью этой функции мы наконец то найдём ответ на этот вопрос - 6.";
        echo "sleep {standby|suspend|off} - отключение экрана монитора";
        echo "p_cpu - сортировка процессов, вывод тех, которые нагружают более 0.1%";
        echo "myip - показывает Ваш внешний ip";
        echo "to_iso - автоматически конвертирует образы в .iso";
        echo "spamcheck IP - проверяет IP в блэклистах";
        echo "my_ps - все процессы юзера";
        echo "mount_iso - монтирует образ диска .iso";
        echo "rnm - переименовывает файлы, заменяет пробелы на _";
        echo "rmtabs - удаляет из файлов табуляторы, заменяет их на 4 пробела";
        echo "rmnpc - удаляет непечатаемые символы из имени файлов";
        echo "bones - не показывает пустые строки и ненужные символы из файлов перед просмотром";
        echo "backup - резервная копия. backup [куда][что]. Исключения вшиты в функцию";
        echo "getWeather - пулучает погодные условия за окном от гугла";
        echo "ebrc - редактированое .bashrc ";
        echo "genpass - генерует случайный пароль ";
        echo "screencast - записываем действия с экрана";
        echo "toiso - создаёт iso file из директории";
        echo "swap - меняем 2 файла местами";
        echo "up - переходим на n уровней вверх";
        echo "mktempdir - создать времменную директорию и перейти в неё";
        echo "mkcd - создать директория и перейти в неё";
        echo "kll - убить все процессы, которые загружают прецессор";
        echo "compilegl - скомпилировать .cpp файл с использованием gl/glut";
        echo "srch - находир файлы содержащие необходимый текст";
        echo "apetoflac - тут всё понятно";
        echo "rmnall - переименовывает все файлы содержащие пробелы";
        echo "down_deposit - качаем с депозита";
        echo "radioplay - играет встроенные радиостанции";
        echo "cp_p - копирование с помощью pv";
        echo "4chanimages - качает все картинки с сайта";
        echo "makeformula - создаёт картинку из latex формулы";
        echo "watchtube - проигрывает ролик с ты_трубы";
        echo "changecardsorder - меняет мои звуковые карты местами";
}


function screencast()
{
if which ffmpeg &>/dev/null; then
        if [ $# -ne 1 ];
        then    echo -e "usage: sreencast resolutionWIDTHxresolustionHEIGHT"
                echo -e "no resolution given using screen resolution instead"
                resolution=$(xdpyinfo | grep -o '[0-9]\{4\}x[0-9]\{4\}')
                echo "$resolution"
                ffmpeg -f x11grab -b 300k -r 24 -s $resolution -i :0.0 ~/screencast.mpg
        else
                regex=[0-9]\{4\}x[0-9]\{4\}
                if [ $1 = $regex ]; then
                        ffmpeg -f x11grab -r 24 -s $1 -i :0.0 ~/screencast.mpg
                else
                        echo -e "could not approve resolution"
                fi
        fi
fi
}


function toiso()
{

if which mkisofs &>/dev/null; then
        if [ $# -ne 2 ];
        then echo -e "usage: toiso outputname inputfolder"
        else mkisofs -r -o $1  $2
        fi
fi
        }

function ii()   # Дополнительные сведения о системе
{
    echo -e "\nВы находитесь на " ; uname -n
    echo -e "\nДополнительная информация:$NC " ; uname -a
    echo -e "\nВ системе работают пользователи:$NC " ; w -h
    echo -e "\nДата:$NC " ; date
    echo -e "\nВремя, прошедшее с момента последней перезагрузки :$NC " ; uptime
    echo -e "\nПамять :$NC " ; free
    echo -e "\n"; myip ;
    echo
}
function up {
    [ "${1/[^0-9]/}" == "$1" ] && {
        local ups=""
            for i in $(seq 1 $1)
                        do
                            ups=$ups"../"
                        done
                    cd $ups
                    } || echo "usage: up INTEGER"
            }
alias mktempdir='tdir=`mktemp -d` && cd $tdir'

# list contents right after changing directories
cd() {
  if [ "$1" ]
  then builtin cd "$1" && ls
  else builtin cd && ls
  fi
}

# make a directory, then immediately cd into it
mkcd() {
  if [ "$1" ]
  then mkdir -p "$1" && cd "$1"
  fi
}
# i use this function in PS1 to represent if the command that was running before exited with 0 code
smiley() {
  err=$?
  if [ -z $STY ]; then
      if [ $err == 0 ]
        then echo "✓" && aplay ~/.bell.wav > /dev/null 2>&1
        else echo "☠ $err" && aplay ~/.error.wav > /dev/null  2>&1
      fi
  else
      if [ $err == 0 ]
        then echo "✓ [scr]"
        else echo "☠ [scr] $err  "
      fi
  fi
}

#small functions
alias path='echo -e ${PATH//:/\\n}'


function kll () {
    if  [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo "Giving a percentage of maximum load, kills every process of the current user that takes a load of CPU greater or equal to that given percentage."
        echo -e "It kills every process that produces a load on the CPU greater or equal than the percentage user defined. Usage ${RED_FG}'kll cpu_percentage_usage'$NC"
        return
    fi
    if [ "$1" -le "50" ]; then
        echo "Is dangerous to kill processes that use less than 50% of the CPU. It's not allowed."
        return
    fi


    local PROCS=`ps -u $USER -o %cpu,pid | tr -d '%CPU' | tr -d 'ID' | tr -d '.'`

    local LOAD_TARGET=`expr $1 \* 10`
    local FLAG=0
    for i in $PROCS; do

        # inform at user and kill process
        if [ $FLAG -eq 1 ]; then
            local CMD=`ps -u $USER -o pid,command | tr -d 'ID' | grep "$i" | head -n 1`
            echo "pid, program: $CMD"
            echo -n "killing... "

            # first try SIGTERM if, fails try SIGKILL
            if kill $i; then
                echo -e "${GREEN_FG}done!$NC\n"
            else
                if kill -9 $i; then echo -e "${GREEN_FG}done!$NC\n"
                else echo -e "${RED_FG}ERROR!$NC\n"; fi
            fi
            FLAG=0
        fi
        # look the % cpu load of all processes
        if [ "$i" -le "1000" ] && [ "$i" -gt "$LOAD_TARGET" ]; then
            local LOAD=`expr $i / 10`
            echo "found process using $LOAD% of cpu"
            FLAG=1
        fi
    done
}


function swapfiles () {
    if [ $# -ne 2 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Swap two files. Usage ${RED_FG}'swapfiles file1 file2'$NC"
        return
    fi
    if [ -f "$1" ] && [ -f "$2" ]; then
        local TMPFILE=tmp.$$
        cp "$1" $TMPFILE
        cp "$2" "$1"
        cp $TMPFILE "$2"
        rm $TMPFILE
    else
        echo "'$1' or '$2', are not valid files"
    fi
}

function compilegl()
{
   if  [ -z "$1" ] || [ -z "$2" ] ; then
    echo -e "usage: compilegl path_to_file_to_compile outputname"
     return

   else
     g++ -O2 -lGLU -lglut -IGL -lGL -IGLU $1 -o $2
   fi
}



function srch () {
    if [ $# = 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        echo -e "Find a word in files under the current directory ignoring .svn, log files and backups. Usage ${RED_FG}'srch word'$NC"
        return
    fi
    grep -n -R $1 * | grep -v "\.svn" | grep -v "\.log" | grep -v "*~"
}

##let us make stage4##
function backup(){
    if [ $# != 2 ]; then
        echo -e "You have to enter the target path to place your backup"
        echo -e "Also you have to enter the directory you want to backup"
        return
    fi
    local backupdir=$2
    local tobackup=$1

    if [ -d "$backupdir" -a -d "$tobackup" ]; then
    local base=$(cat <<EOF
/mnt/*
/media/*
/tmp/*
/proc/*
/sys/*
/dev/*
/etc/mtab
/etc/ssh/ssh_host_*
/var/cache/pacman/pkg/*
/home/*
/var/cache/hald/*
/var/tmp/kdecache-willowisp/http/*
/var/tmp/*
/lost+found/*
/var/run/*
/var/lock/*
EOF
)
        local TAR_OPTIONS="-cpP - --ignore-failed-read -f"
        echo -e "We will create a backup of $tobackup and store it in $backupdir"
        echo -e "We will EXCLUDE this from backup"
        echo -e "${base}"
        echo -e "Select 1 to go, 2 to abbort"
        select answer in yes no; do
            case "${answer}" in
            yes) break;;
            no) exit 0;;
            *) echo -e "Select 1 or 2 please";;
            esac
        done


        echo "${base}" > /tmp/exclude.stage4
        local excludefile=/tmp/exclude.stage4
        local backupname=$( date +"%d_%m_%y"".stage4.tar.bz2" )
        if [ -f "$excludefile" ]; then
            tar "$TAR_OPTIONS" - -C "$tobackup" -X "$excludefile" \
            | pv -s $(du -sb "$tobackup" | awk '{print $1}' | head -n1) \
            | bzip2 -z -4 > "$backupdir""$backupname"
            echo -e "All pending operations completed."
        else
            echo -e "Exclude file can not be oppened. Do you have rights to write in /tmp?. Aborting"
        exit 1
        fi
    else
        echo -e " "$backupdir" or "$tobackup" or both does not exists"
        exit 1
    fi

}


#BAUSTELLE
#converts all .ape's to .flac in directory.it needs an integer argument to go.
#this argument stands for the search depth for .ape's
function apetoflac(){
if which ffmpeg &>/dev/null; then
    COUNTER=$(find . -maxdepth $1 -iname "*.flac" | sed -n '$=')
    until [ $COUNTER -lt 0 ]; do
        export IFS=""
        APEFILE=$(find . -maxdepth $1 -iname "*.flac" | head -n 1 | sed "s/^[./]*//")
        if [ "$APEFILE" ]; then
            FLACFILE=$(echo "$APEFILE" | sed -e "s/.flac/.wav/" )
            echo "-------------------strating conversion----------------------------"
            echo $APEFILE
            echo $FLACFILE
            ffmpeg -i $APEFILE $FLACFILE &>/dev/null
            echo "Converting complete"
            rm -f $APEFILE
            export IFS=" "
            let COUNTER-=1
            echo "Only " "$COUNTER" " files left"
            notify-send "Files to be done with: "  "$COUNTER"
    else
        echo "no .ape found"
        let COUNTER-=1
        export IFS=" "
    fi
   done
else
    echo "ffmeg is not on your system. aborting."
    notify-send "ffmeg is not on your system. aborting."
fi
}

function rnmall(){
#search in current dir for files/dirs with " " in their names
#and rename it with rnm(). rnm() is defined above!
IFS=$'\n'
    COUNTER=$(ls | grep " " | sed -n '$=')
    until [ $COUNTER -lt 0 ]; do
        APEFILE=$(ls | grep " " | head -n 1 )
        if [ "$APEFILE" ]; then
            rnm $APEFILE
    else
        echo "no file to rename"
        export IFS=""
    fi
   done
unset IFS
}


#downloas from deposit
down_deposit(){
    wget -O- -q --post-data 'gateway_result=1' "http://depositfiles.com/ru/files/$(basename ${1})" |
    sed -n -r -e 's/.*<form action=\"([a-z0-9A-Z\/\.:_\-]+)\" method=\"get\" onSubmit=\"download_started.*/wget -c \"\1\"/gp; s/\t+([0-9]{1,3}) минут\(ы\)\./echo Спим \1 минут/gp' | sh
}


showmenu(){
    for v in "$@"; do
        echo "$v"
    done | nl -bt -nrn -s") "
    read -p "select an option: " i
    return "$i"
}

function radioplay(){


   local VAR1='DRS 2'
   local VAR2='Радио культура'
   local VAR3='BBC Radio 3'
   local VAR4='hotmixradio/new'
   local VAR5='hotmixradio/funky'
   local VAR6='relaxrario.ru'
   local VAR7='108.pl'
   local VAR8='di.fm ambient'
   local VAR9='rain_mood'
   local VAR10='mellow_jazz'
   local VAR11='smoth_vocal_jazz'
   local VAR12='pianorama'
   local VARSTOP='dont play and go away'

    while [ 1 ]
    do
        showmenu "$VAR1" "$VAR2" "$VAR3" "$VAR4" "$VAR5" "$VAR6" "$VAR7" "$VAR8" "$VAR9" "$VAR10" "$VAR11" "$VAR12" "$VARSTOP"
        CHOICE=$?
        case ${CHOICE} in
            "1")
                mplayer "http://zlz-stream11.streamserver.ch/1/drs2/mp3_128"
                ;;
            "2")
                mplayer "mms://live.rfn.ru/rcult"
                ;;
            "3")
                mplayer "http://www.bbc.co.uk/radio/listen/live/r3_aaclca.pls"
                ;;
            "4")
                mplayer "http://streaming.hotmix-radio.net/hotmixradio-new-64.flv?start=0"
                ;;
            "5")
                mplayer "http://streaming.hotmix-radio.net/hotmixradio-funky-64.flv?start=0"
                ;;
            "6")
                mplayer "http://chilloutstation.ru:8000/chilloutstation"
                ;;
            "7")
                mplayer "http://81.219.54.211:8004/"
                ;;
            "8")
                mplayer "http://205.188.215.228:8006/"
                ;;
            "9")
                mplayer "http://173.193.205.68/audio1100/RainyMood.ogg"
                ;;
            "10")
                mplayer "http://u16.jazzradio.com/jr_mellowjazz_aacplus.flv"
                ;;
            "11")
                mplayer "http://u16.jazzradio.com/jr_smoothvocals_aacplus.flv"
                ;;
            "12")
                mplayer "http://188.127.226.185/;stream.nsv"
                ;;
            "13")
                break
                ;;
        esac
    done
}


#function runatonce(){
#local maxjobs=2
#while [ $# -gt 0 ]; do
#    count=(`jobs -p`)
#    if [ ${#count[@]} -lt $maxjobs ]; then
#        mplayer $1 &
#        shift
#    fi
#    done
#    wait
#}

##plays quad_dmg sound from quake to report the end of an operation###
function wrap(){
  SUCCESS_SOUND=/home/`whoami`/.quad.wav
  if [ $# -gt 0 ]; then
    "$@"
      EXIT_CODE=$?
    if [ $EXIT_CODE -eq 0 ]; then
       #notify-send -i gtk-apply "$*" "successed" &&
       aplay -q $SUCCESS_SOUND
    else
       #notify-send -i gtk-dialog-error "$*" "failed" &&
       aplay -q $SUCCESS_SOUND
    fi
  fi
return $EXIT_CODE
}


function cp_p(){
    if [ `echo "$2" | grep ".*\/$"` ];
        then pv "$1" > "$2""$1";
        else pv "$1" > "$2"/"$1";
    fi;
}


function 4chanimages()
{
    curl $1 | grep -i "File<a href" | awk -F '<a href="' '{print $4}' | awk -F '" ' '{print $1}' | xargs wget
}

## complete section
complete -cf sudo
complete -cf man

function makeformula()
{
        if [ "$1" = "" ]; then
            echo -e "usage: $0 <latex string without \$>"
            exit
        fi
        [ "$2" != "" ] && PNGNAME="$2" || PNGNAME="out.png"
        mask=tmp_$$
        TEXFILE=${mask}.tex
        cat > ${TEXFILE} << EOF
\documentclass[12pt]{minimal}
\usepackage[english, german]{babel}
\usepackage[utf8]{inputenc}
\usepackage[matrix,arrow,curve]{xy}
\usepackage{amsmath}
\usepackage{amsfonts}
\begin{document}
\setbox0=\hbox{$
EOF
echo "$1" >> ${TEXFILE}
cat >> ${TEXFILE} << EOF
$}
\textwidth=\wd0
\textheight=\ht0
\advance\textwidth by 2em
\advance\textheight by 2\dp0
\vbox{\vss\hbox{\hss\copy0\hss}\vss}
\end{document}
EOF
        latex ${TEXFILE}
        dvipng -D 600 ${mask}.dvi -o ${PNGNAME}
        #rm -f ${mask}*

}


function timer(){
date1=`date +%s`; while true; do     echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; done
}

function watchtube(){
        URL=$1
        shift
        if [ "${URL#http://}" = "$URL" ]
            then
                echo "usage: $0 <youtube-URL> [mplayer args ...]"
                exit
        fi

        echo \"http://www.youtube.com/get_video?video_id=$(wget -q -0 - "$URL"
                           | sed -e '/fullscreenUrl/!d'                          -e "s/.*video_id=\([^']*\).*/\1/"                             -e 's/ /_/g'
                             -e 's/\\\"/"/g'                            )\"                              | xargs mplayer "$@"
}

function saveflash(){
PID=`ps x | grep libflashplayer.so | grep -v grep | awk '{print $1}'`
FD=`lsof -p $PID | grep Flash | awk '{print $4}' | sed 's/u^//'`
cp /proc/$PID/fd/$FD $HOME/vid/"$1"
}

###greetz

echo  " $color_C                                              _____
         _                  _          _       _  |___  |
 ___ ___| |_    ___ ___ ___| |_      _| |_ _ _| |___|  _|
| . | . |  _|  |  _| . | . |  _|_   | . | | | . | -_|_|
|_  |___|_|    |_| |___|___|_| | |  |___|___|___|___|_|
|___|                          |_|
"

if which fortune &>/dev/null; then
     fortune /usr/share/fortune/futurama
fi
echo -ne "\n";

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'


PATH="/home/grrr/perl5/bin${PATH+:}$PATH"; export PATH;
PERL5LIB="/home/grrr/perl5/lib/perl5${PERL5LIB+:}$PERL5LIB"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/grrr/perl5${PERL_LOCAL_LIB_ROOT+:}$PERL_LOCAL_LIB_ROOT"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/grrr/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/grrr/perl5"; export PERL_MM_OPT;
