package stbi

import "core:os"
import "core:strings"

when os.OS == "windows" do foreign import stbiw "../lib/stb_image_write.lib"
when os.OS == "linux" do foreign import stbiw "../lib/stb_image_write.a"

// bind
@(default_calling_convention="c")
foreign stbiw {
	stbi_write_png :: proc(filename: cstring, w, h, comp: i32, data: rawptr, stride_in_bytes: i32) -> i32 ---;
	stbi_write_bmp :: proc(filename: cstring, w, h, comp: i32, data: rawptr) -> i32 ---;
	stbi_write_tga :: proc(filename: cstring, w, h, comp: i32, data: rawptr) -> i32 ---;
	stbi_write_hdr :: proc(filename: cstring, w, h, comp: i32, data: ^f32) -> i32 ---;
	stbi_write_jpg :: proc(filename: cstring, w, h, comp: i32, data: rawptr, quality: i32 /*0 to 100*/) -> i32 ---; 
}

// wrap
write_png :: inline proc(filename: string, w, h, comp: int, data: []u8, stride_in_bytes: int) -> int {
	return cast(int)stbi_write_png(strings.unsafe_string_to_cstring(filename), i32(w), i32(h), i32(comp), &data[0], i32(stride_in_bytes));
}

write_bmp :: inline proc(filename: string, w, h, comp: int, data: []u8) -> int {
	return cast(int)stbi_write_bmp(strings.unsafe_string_to_cstring(filename), i32(w), i32(h), i32(comp), &data[0]);
}

write_tga :: inline proc(filename: string, w, h, comp: int, data: []u8) -> int {
	return cast(int)stbi_write_tga(strings.unsafe_string_to_cstring(filename), i32(w), i32(h), i32(comp), &data[0]);
}

write_hdr :: inline proc(filename: string, w, h, comp: int, data: []f32) -> int {
	return cast(int)stbi_write_hdr(strings.unsafe_string_to_cstring(filename), i32(w), i32(h), i32(comp), &data[0]);
}

write_jpg :: inline proc(filename: string, w, h, comp: int, data: []u8, quality: int) -> int {
	return cast(int)stbi_write_jpg(strings.unsafe_string_to_cstring(filename), i32(w), i32(h), i32(comp), &data[0], i32(quality));
}

write_png_flip :: inline proc(filename: string, w, h: int, $comp: int, data: []u8, stride_in_bytes: int) -> int {
	#assert(comp >= 0 && comp <= 4);
	for j in 0..h/2-1 {
		for i in 0..w-1 {
			k1 := comp*(j*w + i);
			k2 := comp*((h - 1 - j)*w + i);
			data[k1 + 0], data[k2 + 0] = data[k2 + 0], data[k1 + 0];
			when comp > 1 do data[k1 + 1], data[k2 + 1] = data[k2 + 1], data[k1 + 1];
			when comp > 2 do data[k1 + 2], data[k2 + 2] = data[k2 + 2], data[k1 + 2];
			when comp > 3 do data[k1 + 3], data[k2 + 3] = data[k2 + 3], data[k1 + 3];
		}
	}
	return cast(int)stbi_write_png(strings.unsafe_string_to_cstring(filename), i32(w), i32(h), i32(comp), &data[0], i32(stride_in_bytes));
}

write_tga_flip :: inline proc(filename: string, w, h: int, $comp: int, data: []u8) -> int {
	#assert(comp >= 0 && comp <= 4);
	for j in 0..h/2-1 {
		for i in 0..w-1 {
			k1 := comp*(j*w + i);
			k2 := comp*((h - 1 - j)*w + i);
			data[k1 + 0], data[k2 + 0] = data[k2 + 0], data[k1 + 0];
			when comp > 1 do data[k1 + 1], data[k2 + 1] = data[k2 + 1], data[k1 + 1];
			when comp > 2 do data[k1 + 2], data[k2 + 2] = data[k2 + 2], data[k1 + 2];
			when comp > 3 do data[k1 + 3], data[k2 + 3] = data[k2 + 3], data[k1 + 3];
		}
	}
	return cast(int)stbi_write_tga(strings.unsafe_string_to_cstring(filename), i32(w), i32(h), i32(comp), &data[0]);
}