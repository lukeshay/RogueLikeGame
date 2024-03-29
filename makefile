CC = gcc
CXX = g++
ECHO = echo
RM = rm -f

TERM = "\"S2019\""

CFLAGS = -Wall -ggdb3 -funroll-loops -DTERM=$(TERM) #-DNDEBUG
CXXFLAGS = -Wall -ggdb3 -funroll-loops -DTERM=$(TERM) #-DNDEBUG

LDFLAGS = -lncurses

BIN = rlg327
OBJS = rlg327.o io.o dungeon.o item_utils.o character.o parser.o \
       heap.o dice.o priority_queue.o item.o character_utils.o   \


all: $(BIN) etags

$(BIN): $(OBJS)
	@$(ECHO) Linking $@
	@$(CXX) $^ -o $@ $(LDFLAGS)

-include $(OBJS:.o=.d)

%.o: %.c
	@$(ECHO) Compiling $<
	@$(CC) $(CFLAGS) -MMD -MF $*.d -c $<

%.o: %.cpp
	@$(ECHO) Compiling $<
	@$(CXX) $(CXXFLAGS) -MMD -MF $*.d -c $<

.PHONY: all clean clobber etags

clean:
	@$(ECHO) Removing all generated files
	@$(RM) *.o $(BIN) *.d TAGS core vgcore.* gmon.out *.dSYM

clobber: clean
	@$(ECHO) Removing backup files
	@$(RM) *~ \#* *pgm

etags:
	@$(ECHO) Updating TAGS
	@etags *.[ch] *.cpp
