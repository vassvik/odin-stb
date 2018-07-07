when ODIN_OS == "windows" do foreign import stb_rect_pack "lib/stb_rect_pack.lib"
when ODIN_OS == "linux" do foreign import stb_rect_pack "lib/stb_rect_pack.a"

STBRP_HEURISTIC :: enum i32 #export
{
   STBRP_HEURISTIC_Skyline_default=0,
   STBRP_HEURISTIC_Skyline_BL_sortHeight = STBRP_HEURISTIC_Skyline_default,
   STBRP_HEURISTIC_Skyline_BF_sortHeight
};

stbrp_coord :: u16;

stbrp_rect :: struct {
   // reserved for your use:
   id         : i32,
   w, h       : stbrp_coord,
   x, y       : stbrp_coord,
   was_packed : i32,
}

stbrp_node :: struct {
   x,y  : stbrp_coord,
   next : ^stbrp_node,
};

stbrp_context :: struct {
   width       : i32,
   height      : i32,
   align       : i32,
   init_mode   : i32,
   heuristic   : i32,
   num_nodes   : i32,
   active_head : ^stbrp_node,
   free_head   : ^stbrp_node,
   extra       : [2]stbrp_node,
};


@(default_calling_convention="c")
foreign stb_rect_pack {
	stbrp_init_target            :: proc(contex: ^stbrp_context, width: i32, height: i32, nodes: ^stbrp_node, num_nodes: i32) ---;
	stbrp_pack_rects             :: proc(contex: ^stbrp_context, rects: ^stbrp_rect, num_rects: i32) -> i32 ---;
	stbrp_setup_allow_out_of_mem :: proc(contex: ^stbrp_context, allow_out_of_mem: i32) ---;
	stbrp_setup_heuristic        :: proc(contex: ^stbrp_context, heuristic: i32) ---;
}