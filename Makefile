AS=as
LD=ld
OBJ_DIR=obj
BIN_DIR=bin
EXES=$(BIN_DIR)/linux-x86-gas_intel $(BIN_DIR)/linux-x86_64-gas_intel $(BIN_DIR)/win32-console-x86-gas_att.exe $(BIN_DIR)/win32-console-x86_64-gas_intel.exe

.PHONY: all
all: $(OBJ_DIR) $(BIN_DIR) $(EXES)

$(BIN_DIR) $(OBJ_DIR):
	-mkdir "$@"

$(BIN_DIR)/linux-x86-gas_intel: $(OBJ_DIR)/linux-x86-gas_intel.o
	$(LD) $? -melf_i386 -o $@

$(BIN_DIR)/linux-x86_64-gas_intel: $(OBJ_DIR)/linux-x86_64-gas_intel.o
	$(LD) $? -melf_x86_64 -o $@

$(BIN_DIR)/win32-console-x86-gas_att.exe: $(OBJ_DIR)/win32-console-x86-gas_att.o
	i686-w64-mingw32-$(LD) $? -o $@ -lkernel32

$(BIN_DIR)/win32-console-x86_64-gas_intel.exe: $(OBJ_DIR)/win32-console-x86_64-gas_intel.o
	x86_64-w64-mingw32-$(LD) $? -o $@ -lkernel32

$(OBJ_DIR)/linux-x86-gas_intel.o: linux-x86-gas_intel.s
	$(AS) $? -g --32 -o $@

$(OBJ_DIR)/linux-x86_64-gas_intel.o: linux-x86_64-gas_intel.s
	$(AS) $? -g --64 -o $@

$(OBJ_DIR)/win32-console-x86-gas_att.o: win32-console-x86-gas_att.s
	i686-w64-mingw32-$(AS) $? -o $@

$(OBJ_DIR)/win32-console-x86_64-gas_intel.o: win32-console-x86_64-gas_intel.s
	x86_64-w64-mingw32-$(AS) $? -o $@

.PHONY: clean
clean:
	-rm bin -rf
	-rm obj -rf
