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

		direction := string(line[0:1])
		unit, ok := strconv.parse_int(line[1:])
        unit %= 100

		fmt.println("SUM -> ", sum)
		fmt.println("Current", current)
		fmt.printf("dir: %s, unit %d\n", direction, unit)

		if direction == "L" {
            if current - unit == 0 {
                sum += 1
                current = 0
            } else if current - unit < 0 {
                current = 100 - abs(current - unit)
            } else {
                current = current - unit 
            }
		} else {
            if current + unit == 100 {
                sum += 1
                current = 0
            } else if current + unit > 100 {
                current = (current + unit) - 100
            } else {
                current += unit
            }

		}

	}

	fmt.println("SUm is: ", sum)

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

		direction := string(line[0:1])
		unit, ok := strconv.parse_int(line[1:])
        rounds := unit / 100
        unit %= 100

		fmt.println("SUM -> ", sum)
		fmt.println("Current", current)
		fmt.printf("dir: %s, unit %d\n", direction, unit)

		if direction == "L" {
            if current - unit == 0 {
                sum += 1
                current = 0
            } else if current - unit < 0 {
                sum += 1
                current = 100 - abs(current - unit)
            } else {
                current = current - unit 
            }
		} else {
            if current + unit == 100 {
                sum += 1
                current = 0
            } else if current + unit > 100 {
                current = (current + unit) - 100
                sum += 1
            } else {
                current += unit
            }
		}
        sum += rounds
	}

	fmt.println("SUm is: ", sum)


}
