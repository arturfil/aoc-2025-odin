package utils

import "core:strings"
import "core:os"
import "core:fmt"

FileError :: enum {
   FileNotFound 
}

process_file :: proc(filepath: string) -> (string, FileError) {
    data, ok := os.read_entire_file(filepath, context.allocator)
    if !ok {
        fmt.println("Couldn't read the file")
        return "Error no file found", .FileNotFound
    }

    defer delete(data, context.allocator)

    it := string(data)

    return it, nil
}
