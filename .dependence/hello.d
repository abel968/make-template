.objs/hello.o: src/hello.cpp include/hello.hpp
	g++ -o .objs/hello.o -c src/hello.cpp -I include/ -I /usr/local/opencv-3.3.0/include/
