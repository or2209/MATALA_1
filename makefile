CC=gcc
AR=ar
OBJECT_POW_BASIC=power.o basicMath.o
OBJECT_O=power.o basicMath.o main.o
POWER_C=power.c
BASICMATH_C=basicMath.c
FLAGS= -Wall -g

all: mymathd mymaths mains maind
mains: main.o libmyMath.a
	$(CC) $(FLAGS) -o mains main.o libmyMath.a
maind: main.o
	$(CC) $(FLAGS) -o maind main.o ./libmyMath.so
mymathd: libmyMath.so
libmyMath.so: $(OBJECT_POW_BASIC)
	$(CC) -shared -o libmyMath.so $(OBJECT_POW_BASIC)
libmyMath.a: $(OBJECT_POW_BASIC)
	$(AR) -rcs libmyMath.a $(OBJECT_POW_BASIC)	
mymaths: libmyMath.a
main.o: main.c myMath.h
	$(CC) $(FLAGS) -fPIC -c main.c
power.o: power.c myMath.h
	$(CC) $(FLAGS) -fPIC -c power.c
basicMath.o: basicMath.c
	$(CC) $(FLAGS) -fPIC -c basicMath.c

.PHONY: clean all

clean:
	rm -f *.o *.a *.so mains maind 
