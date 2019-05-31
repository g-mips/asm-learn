AS=nasm
LD=ld

SRC_DIR=src
OBJ_DIR=obj
BIN_DIR=bin

WIN_LIBS=-lmsvcrt -lmingw32 -lgcc -lgcc_eh -lmoldname -lmingwex -lmsvcrt -lpthread -ladvapi32 -lshell32 -luser32 -lkernel32
LIB_PATH=-L/usr/lib/gcc/x86_64-w64-mingw32/9.1.0 -L/usr/x86_64-w64-mingw32/lib
WIN_OBJS=/usr/x86_64-w64-mingw32/lib/crt2.o /usr/lib/gcc/x86_64-w64-mingw32/9.1.0/crtbegin.o /usr/lib/gcc/x86_64-w64-mingw32/9.1.0/crtend.o

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
	x86_64-w64-mingw32-$(LD) $? $(WIN_OBJS) $(LIB_PATH) $(WIN_LIBS) -o $@

$(OBJ_DIR)/linux-x86_64-nasm.o: $(SRC_DIR)/linux-x86_64-nasm.asm
	$(AS) -f elf64 $? -o $@

$(OBJ_DIR)/win32-console-x86_64-nasm.o: $(SRC_DIR)/win32-console-x86_64-nasm.asm
	$(AS) -f win64 $? -o $@

$(OBJ_DIR)/win32-gui-x86_64-nasm.o: $(SRC_DIR)/win32-gui-x86_64-nasm.asm
	$(AS) -gcv8 -f win64 $? -o $@

.PHONY: clean
clean:
	-rm bin -rf
	-rm obj -rf
