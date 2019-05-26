AS=nasm
LD=ld
OBJ_DIR=obj
BIN_DIR=bin
EXES=$(BIN_DIR)/linux-x86_64-nasm

.PHONY: all
all: $(OBJ_DIR) $(BIN_DIR) $(EXES)

$(BIN_DIR) $(OBJ_DIR):
	-mkdir "$@"

$(BIN_DIR)/linux-x86_64-nasm: $(OBJ_DIR)/linux-x86_64-nasm.o
	$(LD) $? -o $@

$(OBJ_DIR)/linux-x86_64-nasm.o: linux-x86_64-nasm.asm
	$(AS) -f elf64 $? -o $@

.PHONY: clean
clean:
	-rm bin -rf
	-rm obj -rf
