CXX = g++

TARGET = assembler
OBJECTS = assembler.o
LDFLAGS =

all	: $(TARGET)

$(TARGET) : $(OBJECTS)
	$(CXX) -o $@ $(OBJECTS) $(LDFLAGS)

clean :
	rm *.o $(TARGET)
