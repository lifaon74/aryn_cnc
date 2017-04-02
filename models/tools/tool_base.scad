$fn=20;

include <../XYZ/config.scad>

show_rods       = true;
use_plain_base = true;

base_block_y = 70;

		
/*
    RODS
*/

module positioned_rod(pos_x, show_rods) {
    rod_x = rod_horizontal_spacing / 2;
    translate([rod_x * pos_x, 0 , 0])
    rotate([0, 0, 90])
    rod(show_rods);
}
// draw carriage rods

module rods(show_rods) {
    positioned_rod(1, show_rods);
    positioned_rod(-1, show_rods);
}
// draw all rods


/*
    PIECE
*/

module base_rod_remove_holder() {
    color([0, 1, 0, 0.7])
    rods(true);
}
//base_rod_remove_holder

module base_separator_remove() {
    color([1, 0, 0, 0.7])
    cube([base_block_x + 10, base_block_y + 10, pieces_spacing], center = true);
}
//base_separator_remove

module base_block_remove_ligther() {
    color([1, 0, 0, 0.7])
    cube([base_block_remove_x, base_block_remove_y + 1, base_block_remove_z* 2], center = true);
    
    echo("piece inside x :", base_block_remove_x);
    echo("motor holder thickness :", (base_block_z - base_block_remove_z) / 2, "mm");
}
//base_block_remove_ligther

module base_screw_remove_tighten() {
	color([1, 0, 0, 0.7])
    union() {
        
        screw_length = 30;
				screw_head_diameter = 6;
				screw_head_length = 30; // any value
        nuts_remove_length = 4;
				bottom_thickness = 8;
			
				screw_head_length_z_offset = nuts_remove_length + bottom_thickness;
				translate([0, 0, (screw_length / 2) - screw_head_length_z_offset - 0.001])
			
        cylinder (r=(screw_diameter / 2), h=screw_length, center=true);
    
				translate([0, 0, -(nuts_remove_length / 2)])
				cylinder ($fn = 6, r=(screws_nuts_side_max / 2), h=nuts_remove_length, center=true);

				translate([0, 0, -(screw_head_length / 2) - screw_head_length_z_offset])
				cylinder (r=(screw_head_diameter / 2), h=screw_head_length, center=true);
    }
}
// base_screw_remove_tighten
//base_screw_remove_tighten();


module positioned_base_screw_remove_tighten(pos_x, pos_y) {
    base_screw_remove_tighten_x_outside = (base_block_x / 2) - (screw_virtual_holder_side / 2);
    base_screw_remove_tighten_x_inside = (base_block_remove_x / 2) + (screw_virtual_holder_side / 2);
    base_screw_remove_tighten_y = (base_block_y / 2) - (screw_virtual_holder_side / 2) - 4;
    
    translate([0, base_screw_remove_tighten_y * pos_y, 0])
    union() {
        translate([base_screw_remove_tighten_x_outside * pos_x, 0, 0])
        rotate([0, 0, -45 * pos_y])
        base_screw_remove_tighten();
        
        translate([base_screw_remove_tighten_x_inside * pos_x, 0, 0])
        rotate([0, 0, -45 * pos_y])
        base_screw_remove_tighten();
    }
}
// positioned_base_screw_remove_tighten
//positioned_base_screw_remove_tighten(1, 1);

module base_screws_remove_tighten() {
    positioned_base_screw_remove_tighten( 1,  1);
    positioned_base_screw_remove_tighten( 1, -1);
    positioned_base_screw_remove_tighten(-1,  1);
    positioned_base_screw_remove_tighten(-1, -1);
}
// base_screws_remove_tighten

module base_block() {
    color([1, 1, 0, 0.7])
    cube([base_block_x, base_block_y, base_block_z], center = true);
    echo("piece x :", base_block_x);
    echo("piece y :", base_block_y);
    echo("piece z :", base_block_z);
}
// base_block

/*
    RENDERING
*/

module plain_base() {
	separator_x = pieces_spacing * 2;
	separator_z = (base_block_z / 2) + pieces_spacing;
	
	separator_x_offset = (base_block_remove_x / 2);
	separator_z_offset = -(separator_z / 2) + (pieces_spacing / 2);
	
	color([1, 1, 0, 0.7])
	difference() {
		cube([base_block_remove_x + 0.0001, base_block_remove_y, base_block_z], center = true);
		
		union() {
			translate([separator_x_offset, 0, separator_z_offset])
			cube([separator_x, base_block_y + 10, separator_z], center = true);
			
			translate([-separator_x_offset, 0, separator_z_offset])
			cube([separator_x, base_block_y + 10, separator_z], center = true);
		}
	}
}
// plain_base

module piece(piece_top) {
	difference() {
		base_block();

		union() {
			base_rod_remove_holder();
			base_separator_remove();
			base_block_remove_ligther();
			base_screws_remove_tighten();
		}
	}
}
// piece

module _render_tool_base(cube_pos_z) {
	cube_size = 1000;
	if(cube_pos_z == 0) {
		rods(show_rods);
		union() {
			piece(cube_pos_z);
			if(use_plain_base) plain_base();
		}
	} else {
		union() {
			difference() {
					piece(cube_pos_z);
				
					translate([0, 0, -(cube_size / 2) * cube_pos_z])
					cube([cube_size, cube_size, cube_size], center = true);
				
						translate([-(cube_size / 2), 0, 0])
						cube([cube_size, cube_size, cube_size], center = true);
			}
			
			if(use_plain_base) plain_base();
		}
	}
}


use_plain_base = false;
_render_tool_base(-1); // -1 for bottom, 0, for all, 1 for top










