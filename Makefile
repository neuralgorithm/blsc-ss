CC = gcc
MPICC = mpicc
CFLAGS = -std=c99 -Wall -O3
MISC_OBJS = mt19937ar-cok.o timer.o

all: car neuron1 neuron2 network2 random random_mpi

car: car.c
	$(CC) $(CFLAGS) -o $@ $<
neuron1: neuron1.c
	$(CC) $(CFLAGS) -o $@ $<
neuron2: neuron2.c
	$(CC) $(CFLAGS) -o $@ $<
network2: network2.c
	$(CC) $(CFLAGS) -o $@ $<
random: random.c $(MISC_OBJS)
	$(CC) $(CFLAGS) -o $@ $^ -lm
random_mpi: random_mpi.c $(MISC_OBJS)
	$(MPICC) $(CFLAGS) -o $@ $^ -lm

mt19937ar-cok.o: mt19937ar-cok.c
	$(CC) $(CFLAGS) -o $@ -c $<
timer.o: timer.c
	$(CC) $(CFLAGS) -o $@ -c $<

run:
	mpirun -hostfile hostfile -np 192 ./random_mpi

clean:
	rm -f car neuron1 neuron2 network2 random random_mpi *.o *~
distclean: clean
	rm -f *.dat
