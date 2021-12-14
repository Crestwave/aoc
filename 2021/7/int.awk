#!/usr/bin/awk -f
{ prog = prog $0 }

END {
    base = 0
    split(prog, init, ",")
    for (i = 1; i <= length(init); ++i)
        mem[i-1] = init[i]

    for (ptr = 0; ptr < length(mem);) {
        split(substr(mem[ptr], 1, length(mem[ptr])-2), modes, "")
        c = substr(mem[ptr], length(mem[ptr])-1) + 0

        for (i = 1; i <= 3; ++i) {
            mode = modes[length(modes)-i+1]
            if (mode == 0)
                params[i] = (i == 3 || c == 3) ? \
                      mem[ptr+i] : \
                      mem[mem[ptr+i]]
            else if (mode == 1)
                params[i] = mem[ptr+i]
            else if (mode == 2)
                params[i] = (i == 3 || c == 3) ? \
                      mem[ptr+i] + base : \
                      mem[mem[ptr+i] + base]
        }

        if (c == 1) {
            mem[params[3]] = params[1] + params[2]
            ptr += 4
        } else if (c == 2) {
            mem[params[3]] = params[1] * params[2]
            ptr += 4
        } else if (c == 3) {
            getline input < "-"
            mem[params[1]] = input + 0
            ptr += 2
        } else if (c == 4) {
            printf("%c", params[1])
            ptr += 2
        } else if (c == 5) {
            ptr = params[1] ? params[2] : ptr+3
        } else if (c == 6) {
            ptr = params[1] ? ptr+3 : params[2]
        } else if (c == 7) {
            mem[params[3]] = params[1] < params[2]
            ptr += 4
        } else if (c == 8) {
            mem[params[3]] = params[1] == params[2]
            ptr += 4
        } else if (c == 9) {
            base += params[1]
            ptr += 2
        } else if (c == 99) {
            break
        } else {
            exit(1)
        }
    }
}
