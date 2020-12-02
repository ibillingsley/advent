#!/bin/bash

usage="Usage: $0 [-g <lang>]... [<day>]...
Examples:
  $0                 # Run all solutions
  $0 2020/01         # Run all solutions for a day
  $0 -g js 2020/01   # Run specific solution"
langs=()
while getopts :hg: opt; do
	case $opt in
		g) langs+=($OPTARG);;
		*) echo "$usage"; exit 1;;
	esac
done
shift $((OPTIND-1))
days=($@)

if [ ${#langs[@]} == 0 ]; then
	langs=("js" "zig" "go" "d" "rs")
fi
if [ ${#days[@]} == 0 ]; then
	days=(20*/*/)
fi

for day in ${days[@]%/}; do
	for lang in ${langs[@]}; do
		file="$day/main.$lang"
		if [ -f $file ]; then
			echo -e "\e[32m$file\e[0m"
			case $lang in
				"js")  node $file;;
				"zig") zig run $file;;
				"go")  go run $file;;
				"d")   rdmd $file;;
				"rs")  cargo run -q --bin ${day/\//-};;
			esac
		fi
	done
	echo ""
done
