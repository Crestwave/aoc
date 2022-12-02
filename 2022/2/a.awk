#!/usr/bin/awk -f
BEGIN {
	shape["A"] = 1
	shape["B"] = 2
	shape["C"] = 3
	shape["X"] = 1
	shape["Y"] = 2
	shape["Z"] = 3

	outcome[0] = 3
	outcome[1] = 6
	outcome[2] = 0
}

{ score += outcome[((shape[$2]-shape[$1])+3)%3] + shape[$2] }

END { print(score) }
