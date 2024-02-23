black="\033[30m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
light_gray="\033[37m"

default="\033[39m"

dark_gray="\033[90m"
light_red="\033[91m"
light_green="\033[92m"
light_yellow="\033[93m"
light_blue="\033[94m"
light_magenta="\033[95m"
light_cyan="\033[96m"
white="\033[97m"

base_path=$(readlink -f .)
notif_path=$base_path/notifications

function notify() {
	echo -e "$@" >> $notif_path
}

function runmods() {
	# 1. `find` non-directories in this directory (which may be symbolically linked)
	# 2. sort them lexicographically using `sort`
	# 3. remove the dotfiles directory itself with `tail`
 	mods=($(find $base_path -maxdepth 1 -type d | sort | tail -n+2))

	local doing="$2"
	local done="$3"

	touch $notif_path

	for modpath in "${mods[@]}"
	do
		modfile="$modpath/$1.sh"
		modname=$(basename $modpath | cut -d_ -f2)
		if test -f $modfile; then
			test -n "$doing" && echo -e "\n${light_yellow}$doing $modname${default}"
			source $modfile
			test -n "$done" && echo -e "${light_green}$done $modname${default}"
		fi
	done

        cat $notif_path
	rm $notif_path
}
