all:
	gcc -c -O2 -fPIC stb_image.c stb_image_write.c stb_truetype.c
	ar rcs ../lib/stb_image.a stb_image.o
	ar rcs ../lib/stb_image_write.a stb_image_write.o
	ar rcs ../lib/stb_truetype.a stb_truetype.o
	rm *.o
