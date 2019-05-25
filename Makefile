AS=as
LD=ld
OBJ_DIR=obj
BIN_DIR=bin

.PHONY: all
all: $(BIN_DIR) $(OBJ_DIR) $(BIN_DIR)/linux-x86-gas_intel $(BIN_DIR)/linux-x86_64-gas_intel

$(BIN_DIR) $(OBJ_DIR):
	-mkdir "$@"

$(BIN_DIR)/linux-x86-gas_intel: $(OBJ_DIR)/linux-x86-gas_intel.o
	$(LD) $? -melf_i386 -o $@

$(BIN_DIR)/linux-x86_64-gas_intel: $(OBJ_DIR)/linux-x86_64-gas_intel.o
	$(LD) $? -melf_x86_64 -o $@

$(OBJ_DIR)/linux-x86-gas_intel.o: linux-x86-gas_intel.s
	$(AS) $? --32 -o $@

$(OBJ_DIR)/linux-x86_64-gas_intel.o: linux-x86_64-gas_intel.s
	$(AS) $? --64 -o $@

.PHONY: clean
clean:
	-rm bin -rf
	-rm obj -rf
