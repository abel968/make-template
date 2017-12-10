.objs/hello.o: src/hello.c include/hello.hpp
	cc -o .objs/hello.o -c src/hello.c -I include/ -I /usr/local/opencv-3.3.0/include/
