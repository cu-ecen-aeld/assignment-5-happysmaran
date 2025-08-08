ifndef CROSS_COMPILE
override CROSS_COMPILE=
endif

TARGET=writer

all: $(TARGET)

$(TARGET): $(TARGET)
	$(CC) $(CFLAGS) -o $(TARGET) $(TARGET).c

clean:
	rm -f *.o $(TARGET)
