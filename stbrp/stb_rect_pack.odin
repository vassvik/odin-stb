package stbrp

import "core:os"

when os.OS == "windows" do foreign import stb_rect_pack "../lib/stb_rect_pack.lib"
when os.OS == "linux" do foreign import stb_rect_pack "../lib/stb_rect_pack.a"

STBRP_HEURISTIC :: enum i32
{
   STBRP_HEURISTIC_Skyline_default=0,
   STBRP_HEURISTIC_Skyline_BL_sortHeight = STBRP_HEURISTIC_Skyline_default,
   STBRP_HEURISTIC_Skyline_BF_sortHeight
};

Coord :: u16;

Rect :: struct {
   // reserved for your use:
   id         : i32,
   w, h       : Coord,
   x, y       : Coord,
   was_packed : i32,
}

Node :: struct {
   x,y  : Coord,
   next : ^Node,
};

Context :: struct {
   width       : i32,
   height      : i32,
   align       : i32,
   init_mode   : i32,
   heuristic   : i32,
   num_nodes   : i32,
   active_head : ^Node,
   free_head   : ^Node,
   extra       : [2]Node,
};


@(default_calling_convention="c", link_prefix="stbrp_")
foreign stb_rect_pack {
	init_target            :: proc(contex: ^Context, width: i32, height: i32, nodes: ^Node, num_nodes: i32) ---;
   pack_rects             :: proc(contex: ^Context, rects: ^Rect, num_rects: i32) -> i32 ---;
   setup_allow_out_of_mem :: proc(contex: ^Context, allow_out_of_mem: i32) ---;
	setup_heuristic        :: proc(contex: ^Context, heuristic: i32) ---;
}