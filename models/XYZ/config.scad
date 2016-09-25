include <../parts/switch.scad>


rod_side = 16;
rod_length = 700;

rod_horizontal_spacing	= 120; // center to center / min 105
rod_vertical_spacing	= 2;

bearing_outer_diameter = 10;
bearing_inner_diameter = 3;
bearing_height = 4;

    // avoid touching this except if you know what's you're doing
    
bearing_holder_spacing_1 = 0.7; // space between bearing flat sides and piece
bearing_holder_spacing_2 = 1; // space between bearing perimeter and piece
bearing_holder_width = 3; // thickness of pieces holding the bearings
bearing_screw_access_size = 10; // the size of the cube to remove to be able to put in place the bearing screw

screw_exceed = 3; // how much you want a screew can exceed in length
    // default M3 screws size
screw_diameter = 3; // the diameter of your screws
    // default M3 nuts size
screws_nuts_side_min = 5.75; // 5.4min
screws_nuts_side_max = 6.55; // default is 6mm but we add some margin
screw_nuts_height = 3; // default is 2.4mm
screws_material_holder_min_size = 3; // the minimum of material arround a screw
screws_attach_length = 10; // the min length of the screew which will attach the 2 pieces

rod_holder_size = 10; // the length of material which will tighten the cariage rods

rod_piece_spacing = 1; // space between rod and piece
   
pieces_spacing = 1; // the space between the 2 pieces

motor_holder_thickness = 4; // thickness of motor support


/*
    Computed variables for future use
*/

rod_remove_side = rod_side + (rod_piece_spacing * 2);

    // represent the min size of material which should warp a screw
screw_virtual_holder_side = screw_diameter + (screws_material_holder_min_size * 2);

	// represent the area taken by bearings
bearing_virtual_cube_side = (((rod_side / 2) + bearing_outer_diameter + (bearing_height / 2) + bearing_holder_spacing_1 + bearing_holder_width) / sqrt(2)) * 2;

    // the outers screews could touch the rod, so we need to compute an offset
space_rod_outer = (bearing_virtual_cube_side - (rod_remove_side * sqrt(2))) / 2; // the minimum must be screw_virtual_holder_side
echo("space_rod_outer", space_rod_outer);
outer_screw_offset = abs(screw_virtual_holder_side - space_rod_outer);

	// base piece size
base_block_x = rod_horizontal_spacing + (rod_side * sqrt(2)) + (screw_virtual_holder_side * 2);  
base_block_y = bearing_virtual_cube_side + rod_holder_size /*+ screw_virtual_holder_side*/ + outer_screw_offset;
base_block_z = max(bearing_virtual_cube_side, rod_remove_side * sqrt(2) + motor_holder_thickness * 2);


 base_block_remove_x = rod_horizontal_spacing - (rod_side * sqrt(2)) - (screw_virtual_holder_side * 2);
base_block_remove_y = base_block_y;
base_block_remove_z = max(rod_remove_side * sqrt(2), base_block_z - (motor_holder_thickness * 2));



/*
    RODS
*/

module rod(show_rods) {
    if(show_rods) {
        color([0.7, 0.7, 0.7])
        rotate([45, 0, 0])
        cube([rod_length, rod_side, rod_side], center = true);
    }
}
// draw a rod


module screw() {
    screw_height = 50;
    cylinder (r=(screw_diameter / 2), h=screw_height , center=true);
}




module base_screw_remove_tighten() {
    
    
    color([1, 0, 0, 0.7])
    union() {
        
        screw_length = base_block_z + 1;
        
        cylinder (r=(screw_diameter / 2), h=screw_length, center=true);
    
        nuts_remove_length = (screw_length / 2) - (screws_attach_length / 2);
    
        translate([0, 0, (screw_length / 2) - (nuts_remove_length / 2)])
        cylinder ($fn = 6, r=(screws_nuts_side_max / 2), h=nuts_remove_length, center=true);
        
        translate([0, 0, -((screw_length / 2) - (nuts_remove_length / 2))])
        cylinder ($fn = 6, r=(screws_nuts_side_max / 2), h=nuts_remove_length, center=true);
    }
}
// base_screw_remove_tighten



/*
    SWITCH
*/

switch_x = 19.8;
switch_y = 11.5;
switch_y_total = 15.3;
switch_z = 6.4;
switch_diameter = 2; // 2.5

module switch() {
	
	//difference() {
		
		union() {
				
			translate([0, (switch_y / 2) - 2.9, 0])
			cube([switch_x, switch_y, switch_z], center = true);
			
			switch_pin_y = switch_y_total - switch_y;
			color([0, 1, 0, 0.7])
			translate([0, -(switch_pin_y / 2) - 2.9 + 0.01, 0])
			cube([switch_x, switch_pin_y, switch_z], center = true);
		}
		
		color([1, 0, 0, 0.7])
		union() {
			translate([-9.5 / 2, 0, 0])
			cylinder (r=(switch_diameter / 2), h=20 , center=true);
			translate([ 9.5 / 2, 0, 0])
			cylinder (r=(switch_diameter / 2), h=20 , center=true);
		}
	//}
}
// ss-5gl