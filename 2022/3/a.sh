#!/usr/bin/env bash
while read -r line; do
	a=${line::${#line}/2}
	b=${line:${#line}/2}
	c=${a//["${a//["$b"]}"]}
	c=${c::1}

	printf -v val %d "'$c"

	# alternatively, use a [[ $c =~ [[:lower:]] check
	(( val -= (val >= 97 ? 96 : 38)))
	(( sum += val ))
done <"$1"

printf '%s\n' "$sum"
