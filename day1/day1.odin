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
		return
	}

	defer delete(data, context.allocator)
	it := string(data)

	for line in strings.split_lines_iterator(&it) {
		direction := line[0]
		unit, ok := strconv.parse_int(line[1:])
		unit %= 100

		fmt.println("current", current)

		if direction == 'L' {
			current = current - unit
			if current < 0 {
				current += 100
			}
		} else {
			current = current + unit
			if current >= 100 {
				current -= 100
			}
		}

		if current == 0 do sum += 1
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
		direction := line[0]
		unit, ok := strconv.parse_int(line[1:])

		initial := current
		distance := unit

		sum += (distance / 100)
		distance %= 100

		zero_crossed := 0
		switch direction {
		case 'L':
			{
				if distance > initial {
					// Wrapping backwards past 0
					current = 100 - (distance - initial)
					// Only count if we weren't already at 0
					if initial != 0 {
						zero_crossed = 1
					}
				} else {
					current = initial - distance
					if current == 0 {
						zero_crossed = 1
					}
				}
			}
		case 'R':
			{
				if distance + initial >= 100 {
					// Wrapping forward past 99 to 0 or beyond
					current = (distance + initial) - 100
					// Only count if we don't start at 0
					if initial != 0 {
						zero_crossed = 1
					}
				} else {
					current = distance + initial
					if current == 0 {
						zero_crossed = 1
					}
				}
			}
		}
		sum += zero_crossed
	}

	fmt.println("final sum ->", sum)
}
