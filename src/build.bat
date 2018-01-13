if not exist "..\lib" mkdir ..\lib

cl -nologo -MT -TC -O2 -c stb_image.c stb_image_write.c stb_truetype.c
lib -nologo stb_image.obj -out:..\lib\stb_image.lib
lib -nologo stb_image_write.obj -out:..\lib\stb_image_write.lib
lib -nologo stb_truetype.obj -out:..\lib\stb_truetype.lib

del stb_image.obj stb_image_write.obj stb_truetype.obj
