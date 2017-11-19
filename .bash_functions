#! /bin/bash

# Backup a file with a date-time stamp
# Usage "backup filename.txt"
backup() { cp "$1" "${1}"-"$(date +%Y%m%d%H%M)".backup ; }

# Reload after change in bashrc, no need to open a new terminal and close the old one.
bashrc-reload()
{
	builtin exec bash ;
}

# Check exit status of the last program.
chkec ()
{
	local i=$?
	if [ $i -ne 0 ]; then
		echo -n " Exit Status : $i "
	fi
}

# Progress bar for dd
function dd()
{
	command dd status=progress "$@"
}

# Dupe remover
duperm()
{
	find . -type f -print0 | xargs -0 md5sum | sort |
		perl -ne 'chomp;$ph=$h;($h,$f)=split(/\s+/,$_,2);
		print "$f"."\x00" if ($h eq $ph)'| xargs -0 rm -v --
}

# Handy Extract Program
extract ()
{
	if [ -f "$1" ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf "$1"        ;;
			*.tar.gz)    tar xvzf "$1"        ;;
			*.bz2)       bunzip2 "$1"         ;;
			*.rar)       unrar x "$1"         ;;
			*.gz)        gunzip "$1"          ;;
			*.tar)       tar xvf "$1"         ;;
			*.tbz2)      tar xvjf "$1"        ;;
			*.tgz)       tar xvzf "$1"        ;;
			*.zip)       unzip "$1"           ;;
			*.Z)         uncompress "$1"      ;;
			*.7z)        7z x "$1"            ;;
			*)           echo "'$1' cannot be extracted via \
					>extract<"        ;;
		esac
   	else
		echo "'$1' is not a valid file"
	fi
}

# Searches for text in all files in the current folder
ftext ()
{
	# -i case-insensitive
	# -I ignore binary files
	# -H causes filename to be printed
	# -r recursive search
	# -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines
	# 	ex. grep -irl "$1" *
	grep -iIHrn --color=always "$1" . | less -r
}

# Google from commandline usage: google word1 word2 word3...
# 	google '"this search gets quoted"'
google()
{
	Q="$*"; GOOG_URL='https://www.google.com/search?tbs=li:1&q=';
	AGENT="Mozilla/4.0";
	stream=$(curl -A "$AGENT" -skLm 10 "${GOOG_URL}${Q//\ /+}" | grep -oP '\/url\?q=.+?&amp' | sed 's|/url?q=||; s|&amp||');
	echo -e "${stream//\%/\x}";
}

# Delete exif data from jpg, reconstruct huffman tables.
# Lossless space saver for jpg files.
jpg_optim()
{
	for file in *.jpg ; do
		jpegoptim --strip-all -of "$file"
	done
	notify-send "JPG optimization complete"
}

# Checks if the links are dead or alive given in the file.
# Usage : linkchecker links.txt
linkchecker()
{
	while read -r linx ; do
		http_code=$(curl -I -s "$linx" -w %{http_code});
		echo "$linx" status: "${http_code:9:3}";
	done < "$1"
}

# What is the use of this switch ?
# e.g.manswitch grep -o
manswitch ()
{
	man "$1" | less -p "^ +$2";
}

# Show current network information
netinfo ()
{
	echo "--------------- Network Information ---------------"
	/sbin/ifconfig | awk /'inet addr/ {print $2}'
	echo ""
	/sbin/ifconfig | awk /'Bcast/ {print $3}'
	echo ""
	/sbin/ifconfig | awk /'inet addr/ {print $4}'

	/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
	echo "---------------------------------------------------"
}

# Gets the orginal file from a  hardlink or softlink + also sanity checks
removelink()
{
	[ -L "$1" ] && cp --remove-destination "$(readlink "$1")" "$1"
}

# it starts a process detatched from your shell/terminal, wont pollute your
# terminal with any output and wont die if you close the terminal / shell.
# run as "stfu cmd arg1 arg2 etc".
stfu() {
    ( "$@" & disown -h ) &>/dev/null
}

# Create an directory and cd to it. non clobbering
take()
{
	if [ ! -n "$1" ]; then
		echo "Enter a directory name"
	elif [ -d "$1" ]; then
		echo "\`$1' already exists"
	else
		mkdir "$1" && cd "$1" || return
	fi
}

