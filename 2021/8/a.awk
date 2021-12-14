#!/usr/bin/awk -f
{
	split($0, input, " \\| ")
	split(input[2], output, " ")

	for (i in output)
		if (length(output[i]) ~ /^[2437]$/)
			total += 1
}

END {
	print total
}
