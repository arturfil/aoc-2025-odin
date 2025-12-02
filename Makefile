BINARY=out

all: build run

build:
	odin build ./main.odin -file -out:$(BINARY)

run:
	./$(BINARY)


