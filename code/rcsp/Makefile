CC=g++
CFLAGS=--ansi -O2 -Wall
BIN=bin/rscp
TEST=bin/test
OBJS = bin/base_vertex.o\
			 bin/base_arc.o\
			 bin/constrained_arc.o\
			 bin/base_graph.o\
			 bin/resources.o\
			 bin/instance.o\
			 bin/reader.o\
			 bin/test.o

bin/base_vertex.o: src/graph/base_vertex.cc src/graph/base_vertex.h
	$(CC) $(CFLAGS) -c $< -o $@

bin/base_arc.o: src/graph/base_arc.cc src/graph/base_arc.h
	$(CC) $(CFLAGS) -c $< -o $@

bin/base_graph.o: src/graph/base_graph.cc src/graph/base_graph.h
	$(CC) $(CFLAGS) -c $< -o $@

bin/resources.o: src/graph/resources.cc src/graph/resources.h
	$(CC) $(CFLAGS) -c $< -o $@

bin/constrained_arc.o: src/graph/constrained_arc.cc src/graph/constrained_arc.h
	$(CC) $(CFLAGS) -c $< -o $@

bin/instance.o: src/instance/instance.cc src/instance/instance.h
	$(CC) $(CFLAGS) -c $< -o $@

bin/reader.o: src/instance/reader.cc src/instance/reader.h
	$(CC) $(CFLAGS) -c $< -o $@

bin/test.o: src/test.cc
	$(CC) $(CFLAGS) -c $< -o $@

$(TEST): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@

test: $(TEST)
	./$(TEST)

doc: doxygen.conf
	doxygen doxygen.conf

clean:
	rm -rf $(OBJS) $(BIN) $(TEST)
