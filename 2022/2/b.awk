#!/usr/bin/awk -f
BEGIN {
	shape["A"] = 1
	shape["B"] = 2
	shape["C"] = 3
}

{
	if ($2 == "X")
		score += ((shape[$1]-1)+2) % 3 + 1
	else if ($2 == "Y")
		score += shape[$1] + 3
	else if ($2 == "Z")
		score += ((shape[$1]) % 3) + 6 + 1
}

END { print(score) }
