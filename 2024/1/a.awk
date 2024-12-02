#!/usr/bin/awk -f
function qsort(arr, left, right,        i, j, tmp, pivot) {
        if (left >= 0 && right >= 0 && left < right) {
                pivot = arr[int((left + right) / 2)]

                i = left - 1
                j = right + 1

                while (1) {
                        do {
                                i = i + 1
                        } while (arr[i] < pivot)

                        do {
                                j = j - 1
                        } while (arr[j] > pivot)

                        if (i >= j)
                                break

                        tmp = arr[i]
                        arr[i] = arr[j]
                        arr[j] = tmp
                }

                qsort(arr, left, j)
                qsort(arr, j + 1, right)
        }
}

{
	left[NR] = $1
	right[NR] = $2
}

END {
	qsort(left, 1, NR)
	qsort(right, 1, NR)
	for (i in left)
		total += left[i] - right[i] > 0 ? left[i] - right[i] : right[i] - left[i]
	print(total)
}
