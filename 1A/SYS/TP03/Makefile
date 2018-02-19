all: appli

CC = gcc
OPTC = -Wall -ansi -pedantic

appli: processus.o appli_processus.o
	$(CC) $(OPTC) -o appli processus.o appli_processus.o

processus.o: processus.h processus.c

appli_processus.o: processus.h appli_processus.c

.c.o:
	$(CC) $(OPTC) -c $*.c

clean:
	rm -f appli *.o
