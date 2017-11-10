all:
	gcc -c -O2 -march=native -Os -fPIC stb_image.c stb_image_write.c stb_truetype.c
	ar rcs ../lib/stb_image.a stb_image.o
	ar rcs ../lib/stb_image_write.a stb_image_write.o
	ar rcs ../lib/stb_truetype.a stb_truetype.o
	#gcc -fPIC -shared -Wl,-soname=stb_image.so  -o ../lib/stb_image.so stb_image.o
	#gcc -fPIC -shared -Wl,-soname=stb_image_write.so  -o ../lib/stb_image_write.so stb_image_write.o
	#gcc -fPIC -shared -Wl,-soname=stb_truetype.so  -o ../lib/stb_truetype.so stb_image_truetype.o
	rm *.o
