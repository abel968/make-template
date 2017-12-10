.objs/hi.o: src/hi.cpp include/hi.hpp
	g++ -o .objs/hi.o -c src/hi.cpp -I include/ -I /usr/local/opencv-3.3.0/include/
