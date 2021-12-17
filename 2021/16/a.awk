#!/usr/bin/awk -f
function bin2dec(bin,	i, bit, dec) {
	for (i = 1; i <= length(bin); ++i) {
		bit = substr(bin, i, 1)
		dec = (dec * 2)+bit
	}

	return dec
}

function unpack(packet, extend, count,		i, version, id, val, type, len) {
	version = bin2dec(substr(packet, 1, 3))
	id = bin2dec(substr(packet, 4, 3))
	total += version

	i = 7

	if (id == 4) {
		while (1) {
			val = val substr(packet, i+1, 4)
			i += 5

			if (substr(packet, i-5, 1) == 0) {
				break
			}
		}

		val = bin2dec(val)
	} else {
		type = substr(packet, 7, 1)

		if (type == 0) {
			len = bin2dec(substr(packet, 8, 15))
			i += 1+15
			i += unpack(substr(packet, 23, len), 1, 0)
		} else if (type == 1) {
			count = bin2dec(substr(packet, 8, 11))
			i += 1+11
		}
	}

	if (count > 0) {
		count -= 1
		i += unpack(substr(packet, i), 0, count)
	}

	if (extend) {
		if (length(substr(packet, i))) {
			i += unpack(substr(packet, i), extend, 0)
		}
	}

	return i
}

BEGIN {
	FS = ""
	trans["0"] = "0000"
	trans["1"] = "0001"
	trans["2"] = "0010"
	trans["3"] = "0011"
	trans["4"] = "0100"
	trans["5"] = "0101"
	trans["6"] = "0110"
	trans["7"] = "0111"
	trans["8"] = "1000"
	trans["9"] = "1001"
	trans["A"] = "1010"
	trans["B"] = "1011"
	trans["C"] = "1100"
	trans["D"] = "1101"
	trans["E"] = "1110"
	trans["F"] = "1111"
}

{
	for (i = 1; i <= NF; ++i) {
		packet = packet trans[$i]
	}
}

END {
	unpack(packet)
	print total
}
