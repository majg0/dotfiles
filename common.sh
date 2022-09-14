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

function runmods() {
	mods=($(find -s $(readlink -f .) -depth 1 -type d))

	local doing="$2"
	local done="$3"

	for modpath in "${mods[@]}"
	do
		modfile="$modpath/$1.sh"
		modname=$(basename $modpath | cut -d_ -f2)
		if test -f $modfile; then
			test -n "$doing" && echo "\n${light_yellow}$doing $modname${default}"
			source $modfile
			test -n "$done" && echo "${light_green}$done $modname${default}"
		fi
	done
}

function brew_cask() {
	if brew list $1 &> /dev/null; then
		brew outdated --cask $1 > /dev/null || brew reinstall --cask $1
	else
		brew install --cask $1
	fi
}
