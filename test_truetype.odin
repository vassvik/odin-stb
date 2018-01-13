import "core:fmt.odin";
import "core:os.odin";
import "core:math.odin";

import stbtt "shared:odin-stb/stb_truetype.odin"
import stbi "stb_image_write.odin";


save_bitmap_to_file :: proc(ttf_filename, output_filename: string, width, height, h_oversample, v_oversample: int) {
	using stbtt;
	using stbi;

    ttf_data, ttf_success := os.read_entire_file(ttf_filename);
    if !ttf_success {
        fmt.println("Error, could not read file. Exiting.");
        return;
    }
    defer free(ttf_data);

    glyph_metrics: [16][95]Packed_Char;
    ranges := [...]Pack_Range{{72, 32, nil, 95, &glyph_metrics[0][0],  0, 0},
                              {68, 32, nil, 95, &glyph_metrics[1][0],  0, 0},
                              {64, 32, nil, 95, &glyph_metrics[2][0],  0, 0},
                              {60, 32, nil, 95, &glyph_metrics[3][0],  0, 0},
                              {56, 32, nil, 95, &glyph_metrics[4][0],  0, 0},
                              {52, 32, nil, 95, &glyph_metrics[5][0],  0, 0},
                              {48, 32, nil, 95, &glyph_metrics[6][0],  0, 0},
                              {44, 32, nil, 95, &glyph_metrics[7][0],  0, 0},
                              {40, 32, nil, 95, &glyph_metrics[8][0],  0, 0},
                              {36, 32, nil, 95, &glyph_metrics[9][0],  0, 0},
                              {32, 32, nil, 95, &glyph_metrics[10][0], 0, 0},
                              {28, 32, nil, 95, &glyph_metrics[11][0], 0, 0},
                              {24, 32, nil, 95, &glyph_metrics[12][0], 0, 0},
                              {20, 32, nil, 95, &glyph_metrics[13][0], 0, 0},
                              {16, 32, nil, 95, &glyph_metrics[14][0], 0, 0},
                              {12, 32, nil, 95, &glyph_metrics[15][0], 0, 0}};

    bitmap := make([]u8, width*height);
    defer free(bitmap);

    pc, success_pack := pack_begin(bitmap, width, height, 0, 1);   
    pack_set_oversampling(&pc, h_oversample, v_oversample); // say, choose 3x1 oversampling for subpixel positioning
    pack_font_ranges(&pc, ttf_data, 0, ranges[...]);
    pack_end(&pc);


    color_image := make([]u8, 3*width*height);
    defer free(color_image);

    // color each size differently:
    for i in 0..16 {
        R := 0.5 + 0.5*math.cos(2.0*f64(i));
        G := 0.5 + 0.5*math.cos(3.0*f64(i));
        B := 0.5 + 0.5*math.cos(5.0*f64(i));
        for j in 0..95 {
            m := glyph_metrics[i][j];
            for y in m.y0...m.y1 {
                for x in m.x0...m.x1 {
                    id := int(y)*height + int(x);

                    p := bitmap[id];
                    color_image[3*id+0] = u8(R*f64(p));
                    color_image[3*id+1] = u8(G*f64(p));
                    color_image[3*id+2] = u8(B*f64(p));
                }
            }
        }
    }

    write_png(output_filename, width, height, 3, color_image, 0);
}

main :: proc() {
    save_bitmap_to_file("consola.ttf", "test.png", 1024, 1024, 1, 1);
}