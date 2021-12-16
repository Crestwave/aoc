#!/usr/bin/awk -f
function bin2dec(bin,	i, bit, dec) {
	for (i = 1; i <= length(bin); ++i) {
		bit = substr(bin, i, 1)
		dec = (dec * 2)+bit
	}

	return dec
}

function unpack(packet,	version, id, val, type, len) {
	version = bin2dec(substr(packet, 1, 3))
	id = bin2dec(substr(packet, 4, 3))

	print version, id

	if (ptr > 0) {
		if (--stack[ptr] == 0) {
			ptr -= 1
		}
	}

	if (id == 4) {
		for (i = 7 ;; i += 5) {
			val = val substr(packet, i+1, 4)
			if (substr(packet, i, 1) == 0) {
				break
			}
		}

		# 2021
		print bin2dec(val)

	} else {
		type = substr(packet, 7, 1)

		if (type == 0) {
			len = bin2dec(substr(packet, 8, 15))
			print len
			print substr(packet, 23, len)
			unpack(substr(packet, 23, len))
		} else if (type == 1) {
			stack[++ptr] = bin2dec(substr(packet, 8, 11))
			print len
			unpack(packet)
		}
	}
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

	print packet
}

END {
	unpack(packet)
}
