$fn=100;

include <../../config.scad>

show_screws     = true;
show_bearings   = true;
show_rods       = true;


rod_horizontal_spacing_half = rod_horizontal_spacing / 2;
rod_vertical_spacing_half = (rod_side * sqrt(2) + rod_vertical_spacing) / 2;

base_block_height = rod_vertical_spacing_half * 2 +base_block_z;


/*
	RODS
*/
module rods() {
	translate([0, rod_horizontal_spacing_half, rod_vertical_spacing_half])
	rod(show_rods);

	translate([0, -rod_horizontal_spacing_half, rod_vertical_spacing_half])
	rod(show_rods);

	rotate([0, 0, 90])
	translate([0, rod_horizontal_spacing_half, -rod_vertical_spacing_half])
	rod(show_rods);

	rotate([0, 0, 90])
	translate([0, -rod_horizontal_spacing_half, -rod_vertical_spacing_half])
	rod(show_rods);
}
// positioned rods

module rods_remove_bearing() {
    color([1, 0, 0, 0.7])
    rotate([45, 0, 0])
    cube([rod_length, rod_remove_side, rod_remove_side], center = true);
}
// rod + margin

module rods_remove() {
	translate([0, rod_horizontal_spacing_half, rod_vertical_spacing_half])
	rods_remove_bearing();

	translate([0, -rod_horizontal_spacing_half, rod_vertical_spacing_half])
	rods_remove_bearing();

	rotate([0, 0, 90])
	translate([0, rod_horizontal_spacing_half, -rod_vertical_spacing_half])
	rods_remove_bearing();

	rotate([0, 0, 90])
	translate([0, -rod_horizontal_spacing_half, -rod_vertical_spacing_half])
	rods_remove_bearing();
}
// positioned rods + margin to remove


/*
    PIECE
*/


module base_block_remove() {
	echo("base_block_inside_side", base_block_remove_x);
	
    color([1, 0, 0, 0.7])
    translate([0, 0, 0])
    cube([base_block_remove_x, base_block_remove_x, base_block_height + 1], center = true);
}

module base_block() {
	echo("base_block_height", base_block_height);
    color([1, 1, 0, 0.7])
    translate([0, 0, 0])
    cube([base_block_x, base_block_x, base_block_height], center = true);
}


/*
    RENDERING
*/


module piece() {
    difference() {
        base_block();
        rods_remove();
		base_block_remove();
    }
}

rods();
piece();
