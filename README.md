# odin-stb


WORK IN PROGRESS bindings to the stb single header libraries

We need to compile the headers as a library to bind to them in Odin. Note that we prefer static libs. 

Use the supplied Makefil or build.bat in src to build. 

Note: stb_image is done, while the rest are incomplete and does not work.


## Example stb_image:

```
import stbi "shared:odin-stb/stb_image.odin"

main :: proc() {
	x, y, c: i32;
	data := stbi.load("test.png", &x, &y, &c, 3);
	fmt.println(data, x, y, c);
}
```