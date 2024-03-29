TARGET=.
OBJ=./obj
FLAGS=-f elf64

__start__: $(TARGET)/fizzbuzz
	$(TARGET)/fizzbuzz

$(TARGET)/fizzbuzz: $(OBJ)/fizzbuzz.o
	ld -o $(TARGET)/fizzbuzz $(OBJ)/fizzbuzz.o

$(OBJ):
	mkdir -p $(OBJ)

$(OBJ)/fizzbuzz.o: src/fizzbuzz.asm
	nasm $(FLAGS) -o $(OBJ)/fizzbuzz.o src/fizzbuzz.asm

clear:
	rm -f $(OBJ)/*.o
