#!/usr/bin/env bash
while read -r line; do
	a=${line::${#line}/2}
	b=${line:${#line}/2}
	[[ $a =~ [$b] ]]
	c=${BASH_REMATCH[0]}

	printf -v val %d "'$c"

	(( val -= (val >= 97 ? 96 : 38)))
	(( sum += val ))
done <"$1"

printf '%s\n' "$sum"
