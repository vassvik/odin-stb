when ODIN_OS == "windows" do foreign import stb_rect_pack "lib/stb_rect_pack.lib"
when ODIN_OS == "linux" do foreign import stb_rect_pack "lib/stb_rect_pack.a"

STBRP_HEURISTIC :: enum i32 #export
{
   STBRP_HEURISTIC_Skyline_default=0,
   STBRP_HEURISTIC_Skyline_BL_sortHeight = STBRP_HEURISTIC_Skyline_default,
   STBRP_HEURISTIC_Skyline_BF_sortHeight
};

coord :: u16;

rect :: struct {
   // reserved for your use:
   id         : i32,
   w, h       : coord,
   x, y       : coord,
   was_packed : i32,
}

node :: struct {
   x,y  : coord,
   next : ^node,
};

ctx :: struct {
   width       : i32,
   height      : i32,
   align       : i32,
   init_mode   : i32,
   heuristic   : i32,
   num_nodes   : i32,
   active_head : ^node,
   free_head   : ^node,
   extra       : [2]node,
};


@(default_calling_convention="c", link_prefix="stbrp_")
foreign stb_rect_pack {
	init_target            :: proc(contex: ^ctx, width: i32, height: i32, nodes: ^node, num_nodes: i32) ---;
	pack_rects             :: proc(contex: ^ctx, rects: ^rect, num_rects: i32) -> i32 ---;
	setup_allow_out_of_mem :: proc(contex: ^ctx, allow_out_of_mem: i32) ---;
	setup_heuristic        :: proc(contex: ^ctx, heuristic: i32) ---;
}

main :: proc() {

}
