OBJE= main.o sosil1.o sosil2.o sosil3.o sosil4.o sosil5.o
sosil: $(OBJE)
	gcc -o $@ $^
c.o:
	gcc -c $< $(OBJE)
clean:
	rm -f sosil $(OBJE)
