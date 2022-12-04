#!/usr/bin/env bash
mapfile -t lines <"$1"

for (( i = 0; i < ${#lines[@]}; i += 3 )); do
	a=${lines[i]}
	b=${lines[i+1]}
	c=${lines[i+2]}
	d=${a//["${a//["$b"]}"]}
	d=${c//["${c//["$d"]}"]}
	d=${d::1}

	printf -v val %d "'$d"

	(( val -= (val >= 97 ? 96 : 38)))
	(( sum += val ))
done

printf '%s\n' "$sum"
