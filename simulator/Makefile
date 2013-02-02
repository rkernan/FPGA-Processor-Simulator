# program name
PROG=isa_sim
# files
SRC_FILES=
INC_FILES=
OBJ_FILES=$(SRC_FILES:.c=.o)
# directories
SRC_DIR=src
INC_DIR=src
OBJ_DIR=obj
# libraries
LIB_DIRS=
LIBS=
# compiler / linker
CC=gcc
LD=gcc
# flags
CC_FLAGS=-pedantic -Wall -Werror -std=c11
LD_FLAGS=-pedantic -Wall -Werror -std=c11
# commands
RM=rm -f
MKDIR=mkdir
RMDIR=rmdir

########################################
# DO NOT EDIT BELOW
########################################

# define sources
VPATH=$(SRC_DIR)

# define objects with directory
OBJS_=$(patsubst %,$(OBJ_DIR)/%,$(OBJ_FILES))

# create library options
LIBS_=$(addprefix -L,$(LIB_DIRS)) $(addprefix -l,$(LIBS))

# default option: build
.PHONY: all
all: build
build: $(OBJ_DIR) $(PROG)

# create object directory
$(OBJ_DIR):
	@$(MKDIR) $(OBJ_DIR)

# compile source files
$(OBJ_DIR)/%.o: %.c
	@echo " CC  $<"
	@$(CC) -c -I$(INC_DIR) -o $@ $< $(CC_FLAGS)

# link executable
$(PROG): $(OBJS_)
	@echo " LD  $@"
	@$(LD) -o $@ $^ $(LD_FLAGS) $(LIBS_)

# remove object files
.PHONY: clean
clean:
	@$(RM) $(OBJS_)

# remove executable
.PHONY: distclean
distclean: clean
	@$(RM) $(PROG)
