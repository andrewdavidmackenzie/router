HEADERS = optimal.h road_system.h
SOURCE =  optimal.c main.c road_system.c

default: calculate

calculate: $(SOURCE) $(HEADERS)
	@cc $(SOURCE) -o calculate
	@echo "compiled to 'calculate'"

clean:
	rm -f *.o
	rm -f calculate