#####################################################################
# Setting in Makefile top-level
# 	The cross-compiler directory
# 		PATH :=
# 	The target architecture and platform
# 		ARCH :=
# 	Cross-compiler settings
# 		CROSS_COMPILE :=
# 		CC := $(CROSS_COMPILE)gcc
# 		AS := $(CROSS_COMPILE)as
# 		LD := $(CROSS_COMPILE)ld
# 	CFLAGS
#####################################################################

#####################################################################
TYPE = bin
APP_NAME = hello

# Source file
SRC = hello.c
#####################################################################

# Generate directory
GEN_DIR = $(APP_DIR)/$(APP_NAME)/.$(TYPE)
# Output executable name
TARGET = $(GEN_DIR)/$(APP_NAME)
# Object file
OBJ = $(GEN_DIR)/$(SRC:.c=.o)

# Create the output directory
$(shell mkdir -p $(GEN_DIR))
$(shell mkdir -p $(OUTPUT_APP)/$(TYPE))

# Default target
all: $(TARGET)

# Link the object file into the executable
$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^ || exit ; \
	cp $(TARGET) $(OUTPUT_APP)/$(TYPE)

# Compile source into object file
$(GEN_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(GEN_DIR)

.PHONY: all clean
