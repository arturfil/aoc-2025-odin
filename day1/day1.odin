package day1

import "../utils"
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

problem1 :: proc(filepath: string) {

	current: int = 50
	sum: int = 0

    data, ok := os.read_entire_file(filepath, context.allocator)
    if !ok {
        fmt.println("Couldn't read the file")
        // return "Error no file found", .FileNotFound
        return 
    }

    defer delete(data, context.allocator)
    it := string(data)

	for line in strings.split_lines_iterator(&it) {
		direction := string(line[0:1])
		unit, ok := strconv.parse_int(line[1:])
        unit %= 100

        fmt.println("current", current)

		if direction == "L" {
            current = current - unit % 100
            // if current < 0 do current += 100
		} else {
            current = current + unit % 100  
        }

        if current % 100 == 0 do sum += 1
	}

	fmt.println("SUM ->", sum)
}

problem2 :: proc(filepath: string) {
	current: int = 50
	sum: int = 0

	data, ok := os.read_entire_file(filepath, context.allocator)
	if !ok {
		fmt.println("Couldn't read the file")
		return
	}
	defer delete(data, context.allocator)
	it := string(data)

	for line in strings.split_lines_iterator(&it) {
		if len(line) == 0 do continue

		direction := line[0]
		unit, ok := strconv.parse_int(line[1:])

		if direction == 'L' {
			if unit > current do sum += 1
			current -= unit
			if current < 0 do current += 100
		} else {
			if (current + unit) >= 100 do sum += 1
			current += unit
			if current >= 100 do current -= 100
		}
	}

    fmt.println("final sum->", sum)

}
