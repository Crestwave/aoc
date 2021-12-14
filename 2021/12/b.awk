#!/usr/bin/awk -f
function walk(map, path, ptr, node, time,	i, j, visited, _path, _node, _time) {
	path[++ptr] = node

	if (node == "end") {
		total += 1
		return
	}

	for (i = 1; i <= map[node]; ++i) {
		_node = map[node, i]

		visited = 0

		if (tolower(_node) == _node)
			for (j in path)
				if (path[j] == _node)
					visited = 1

		if (_node == "start")
			continue

		_time = time

		if (visited == 1 && ! time) {
			visited = 0
			_time = 1
		}

		if (! visited) {
			for (j in path)
				_path[j] = path[j]

			walk(map, _path, ptr, _node, _time)
		}
	}
}

BEGIN { FS = "-" }

{
	map[$1, ++map[$1]] = $2
	map[$2, ++map[$2]] = $1
}

END {
	walk(map, path, ptr, "start", 0)
	print total
}
