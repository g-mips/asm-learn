AS=nasm
LD=ld
OBJ_DIR=obj
BIN_DIR=bin
EXES=$(BIN_DIR)/linux-x86_64-nasm $(BIN_DIR)/win32-console-x86_64-nasm.exe $(BIN_DIR)/win32-gui-x86_64-nasm.exe

.PHONY: all
all: $(OBJ_DIR) $(BIN_DIR) $(EXES)

$(BIN_DIR) $(OBJ_DIR):
	-mkdir "$@"

$(BIN_DIR)/linux-x86_64-nasm: $(OBJ_DIR)/linux-x86_64-nasm.o
	$(LD) $? -o $@

$(BIN_DIR)/win32-console-x86_64-nasm.exe: $(OBJ_DIR)/win32-console-x86_64-nasm.o
	x86_64-w64-mingw32-$(LD) $? -o $@ -lkernel32

$(BIN_DIR)/win32-gui-x86_64-nasm.exe: $(OBJ_DIR)/win32-gui-x86_64-nasm.o
	x86_64-w64-mingw32-$(LD) -e WinMain $? -o $@ -lkernel32 -luser32 --subsystem=windows

$(OBJ_DIR)/linux-x86_64-nasm.o: linux-x86_64-nasm.asm
	$(AS) -f elf64 $? -o $@

$(OBJ_DIR)/win32-console-x86_64-nasm.o: win32-console-x86_64-nasm.asm
	$(AS) -f win64 $? -o $@

$(OBJ_DIR)/win32-gui-x86_64-nasm.o: win32-gui-x86_64-nasm.asm
	$(AS) -gcv8 -f win64 $? -o $@

.PHONY: clean
clean:
	-rm bin -rf
	-rm obj -rf
