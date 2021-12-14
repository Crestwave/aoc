#!/usr/bin/awk -f
{
	if ($0 > i && i != "")
		n += 1

	i = $0
}

END { print n }
