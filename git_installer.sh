#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

path=$1

usage () {
	printf "\n${NC}usage: $0 <destination folder>\n\n"
	printf "${NC}example usage: $0 /opt\n\n"
	exit
}

if [ "$#" -ne 1 ]; then
	usage 
fi
if [ -z $path ]; then
	printf "${RED}No destination folder provided...\n"
	usage
fi
if [ ! -d "$path" ]; then
	printf "${GREEN}Creating $path...\n"
	mkdir $path
else
	printf "${YELLOW}$path exists moving forward...\n"
fi

tools=(
# OSINT
"sherlock-project/sherlock Datalux/Osintgram"

#Camera hacks
"techchipnet/CamPhish"

#DDOS
"laorynas/Saphyra"

#Location
"thewhiteh4t/seeker"
)

cats=(
"OSINT"
"Camera"
"DDOS"
"Location"
)


get_git_tools () {
	export i=0
	for list in "${tools[@]}"
		do
		mkdir -p $path/${cats[$i]}
		printf "\n\n${NC}Downloading Category: ${YELLOW}${cats[$i]}\n\n"
		for repo in $list
			do
			tool_name=$(echo $repo | cut -f2 -d "/")
			printf "\n${GREEN}[+] ${NC}Cloning into ${GREEN}${tool_name}${BLUE}\n"
			git clone https://github.com/${repo}.git ${path}/${cats[$i]}/${tool_name}
		done
		i=$((i+1))
	done
}

get_git_tools