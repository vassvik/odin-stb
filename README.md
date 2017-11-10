# odin-stb


cl -nologo -MT -TC -c stb_image.c
lib -nologo stb_image.obj -out:stb_image.lib
lib -nologo stb_image_write.obj -out:stb_image_write.lib
lib -nologo stb_truetype.obj -out:stb_truetype.lib