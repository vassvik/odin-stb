package stbi

import "core:os"

when os.OS == "windows" do foreign import stbiw "../lib/stb_image_write.lib"
when os.OS == "linux" do foreign import stbiw "../lib/stb_image_write.a"

// bind
@(default_calling_convention="c")
foreign stbiw {
	stbi_write_png :: proc(filename: ^u8, w, h, comp: i32, data: rawptr, stride_in_bytes: i32) -> i32 ---;
}

// wrap
write_png :: proc(filename: string, w, h, comp: int, data: []u8, stride_in_bytes: int) -> int {
	return cast(int)stbi_write_png(&filename[0], i32(w), i32(h), i32(comp), &data[0], i32(stride_in_bytes));
}
