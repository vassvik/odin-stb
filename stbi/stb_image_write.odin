package stbi

import "core:os"

when os.OS == "windows" do foreign import stbiw "../lib/stb_image_write.lib"
when os.OS == "linux" do foreign import stbiw "../lib/stb_image_write.a"

// bind
@(default_calling_convention="c")
foreign stbiw {
	stbi_write_png :: proc(filename: ^u8, w, h, comp: i32, data: rawptr, stride_in_bytes: i32) -> i32 ---;
	stbi_write_bmp :: proc(filename: ^u8, w, h, comp: i32, data: rawptr) -> i32 ---;
	stbi_write_tga :: proc(filename: ^u8, w, h, comp: i32, data: rawptr) -> i32 ---;
	stbi_write_hdr :: proc(filename: ^u8, w, h, comp: i32, data: ^f32) -> i32 ---;
	stbi_write_jpg :: proc(filename: ^u8, w, h, comp: i32, data: rawptr, quality: i32 /*0 to 100*/) -> i32 ---; 
}

// wrap
write_png :: inline proc(filename: string, w, h, comp: int, data: []u8, stride_in_bytes: int) -> int {
	return cast(int)stbi_write_png(&filename[0], i32(w), i32(h), i32(comp), &data[0], i32(stride_in_bytes));
}

write_bmp :: inline proc(filename: string, w, h, comp: int, data: []u8) -> int {
	return cast(int)stbi_write_bmp(&filename[0], i32(w), i32(h), i32(comp), &data[0]);
}

write_tga :: inline proc(filename: string, w, h, comp: int, data: []u8) -> int {
	return cast(int)stbi_write_tga(&filename[0], i32(w), i32(h), i32(comp), &data[0]);
}

write_hdr :: inline proc(filename: string, w, h, comp: int, data: []f32) -> int {
	return cast(int)stbi_write_hdr(&filename[0], i32(w), i32(h), i32(comp), &data[0]);
}

write_jpg :: inline proc(filename: string, w, h, comp: int, data: []u8, quality: int) -> int {
	return cast(int)stbi_write_jpg(&filename[0], i32(w), i32(h), i32(comp), &data[0], i32(quality));
}

write_png_flip :: inline proc(filename: string, w, h, comp: int, data: []u8, stride_in_bytes: int) -> int {
	for j in 0..h/2-1 {
		for i in 0..w-1 {
			k1 := 4*(j*w + i);
			k2 := 4*((h - 1 - j)*w + i);
			data[k1 + 0], data[k2 + 0] = data[k2 + 0], data[k1 + 0];
			data[k1 + 1], data[k2 + 1] = data[k2 + 1], data[k1 + 1];
			data[k1 + 2], data[k2 + 2] = data[k2 + 2], data[k1 + 2];
			data[k1 + 3], data[k2 + 3] = data[k2 + 3], data[k1 + 3];
		}
	}
	return cast(int)stbi_write_png(&filename[0], i32(w), i32(h), i32(comp), &data[0], i32(stride_in_bytes));
}