when ODIN_OS == "windows" do foreign import stbi "lib/stb_image_write.lib"
when ODIN_OS == "linux" do foreign import stbi "lib/stb_image_write.a"

// bind
@(default_calling_convention="c")
foreign stbi {
	stbi_write_png :: proc(filename: ^u8, w, h, comp: i32, data: rawptr, stride_in_bytes: i32) -> i32 ---;
}

// wrap
write_png :: proc(filename: string, w, h, comp: int, data: []u8, stride_in_bytes: int) -> int {
	return cast(int)stbi_write_png(&filename[0], i32(w), i32(h), i32(comp), &data[0], i32(stride_in_bytes));
}

test_image_write :: proc() {
	w, h, c := 512, 512, 3;
	
	data := make([]u8, c*w*h);
	defer free(data);
	for i in 0..w*h {
		data[3*i+0] = 255;
		data[3*i+1] = 128;
		data[3*i+2] = 0;
	}

	filename := "test.png";
	write_png("test.png", w, h, c, data, w*c);
}