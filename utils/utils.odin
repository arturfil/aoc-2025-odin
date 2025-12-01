package utils

import "core:strings"
import "core:os"
import "core:fmt"

read_file :: proc(filepath: string) {
    data, ok := os.read_entire_file(filepath, context.allocator)
    if !ok {
        fmt.println("Couldn't read the file")
        return
    }

    defer delete(data, context.allocator)

    it := string(data)
    for line in strings.split_lines_iterator(&it) {
        fmt.println(line)
    }
}
