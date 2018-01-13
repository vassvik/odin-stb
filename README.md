# odin-stb


cl -nologo -MT -TC -c stb_image.c
lib -nologo stb_image.obj -out:stb_image.lib
lib -nologo stb_image_write.obj -out:stb_image_write.lib
lib -nologo stb_truetype.obj -out:stb_truetype.lib

gcc -c -O2 -fPIC stb_image.c stb_image_write.c stb_truetype.c
ar rcs ../lib/stb_image.a stb_image.o
ar rcs ../lib/stb_image_write.a stb_image_write.o
ar rcs ../lib/stb_truetype.a stb_truetype.o
gcc -fPIC -shared -Wl,-soname=stb_image.so  -o ../lib/stb_image.so stb_image.o
gcc -fPIC -shared -Wl,-soname=stb_image_write.so  -o ../lib/stb_image_write.so stb_image_write.o
gcc -fPIC -shared -Wl,-soname=stb_truetype.so  -o ../lib/stb_truetype.so stb_image_truetype.o
