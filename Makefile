TARGET_EXEC ?= /bin/rbuse
SRC ?= ./src/rbuse.c

default:
	gcc $(SRC) -o $(TARGET_EXEC)
