$fn=20;

include <../../config.scad>

show_screws     = true;
show_bearings   = true;
show_rods       = true;


/*
    Computed variables for future use
*/
    // base position
base_block_pos_y = (base_block_y / 2) - (bearing_virtual_cube_side / 2)/* - screw_virtual_holder_side*/ - outer_screw_offset;

    // bearing x and z position
bearing_pos = (bearing_outer_diameter + rod_side) / (2 * sqrt(2));




/*
    RODS
*/

module positioned_rod(pos_x, show_rods) {
    rod_x = rod_horizontal_spacing / 2;
    rod_y = (rod_length / 2) + (bearing_virtual_cube_side / 2);
    
    translate([rod_x * pos_x, rod_y , 0])
    rotate([0, 0, 90])
    rod(show_rods);
}
// draw cariage rods

module rods(show_rods) {
    rod(show_rods);
    positioned_rod(1, show_rods);
    positioned_rod(-1, show_rods);
}
// draw all rods



/*
    BEARINGS
*/
module bearing(show_bearing_remove_block) {
    if(show_bearing_remove_block) {
            // sizes
        bearing_center_x = bearing_outer_diameter + (bearing_holder_spacing_2 * 2);
        bearing_center_y = bearing_height + (bearing_holder_spacing_1 * 2);
        bearing_center_z = bearing_center_x;
        
        
        bearing_screw_access_length = 50;
        bearing_screw_access_pos_y = (bearing_screw_access_length / 2) + (bearing_center_y / 2) + bearing_holder_width;
        
        color([0.5, 0, 0, 0.7])
        union() {
            cube([bearing_center_x, bearing_center_y, bearing_center_z], center = true);
            
            translate([0, bearing_screw_access_pos_y, 0])
            cube([bearing_screw_access_size, bearing_screw_access_length, bearing_screw_access_size], center = true);
            
            translate([0, -bearing_screw_access_pos_y, 0])
            cube([bearing_screw_access_size, bearing_screw_access_length, bearing_screw_access_size], center = true);
        
            rotate([90, 0, 0])
            cylinder (r=(screw_diameter / 2), h=bearing_screw_access_length , center=true);
        }
        
        
    } else {
        if(show_bearings) {
            rotate([90, 0, 0])
            color([0.9, 0.9, 0.9])
            difference() {
                cylinder (r=(bearing_outer_diameter / 2), h=bearing_height, center=true);
                cylinder (r=(bearing_inner_diameter / 2), h=bearing_height + 1, center=true);
            }
        }
        
        if(show_screws) {
            screw_length = bearing_height + (bearing_holder_spacing_1 + bearing_holder_width + screw_exceed) * 2;
            rotate([90, 0, 0])
            color([0.2, 0.2, 0.2])
            cylinder (r=(screw_diameter / 2), h=screw_length , center=true);
        }
    }
}
// draw a bearing

    
module positioned_bearing(pos_x, pos_y, pos_z, show_bearing_remove_block) {
    translate([pos_x * (rod_horizontal_spacing / 2), pos_y * bearing_pos, pos_z * bearing_pos])
    rotate([-45 * pos_y * pos_z, 0, 0])
    bearing(show_bearing_remove_block);
}
// position one bearing

    
module positioned_bearings_group(pos_x, show_bearing_remove_block) {
    positioned_bearing(pos_x, 1, 1, show_bearing_remove_block);
    positioned_bearing(pos_x, -1, 1, show_bearing_remove_block);
    positioned_bearing(pos_x, 1, -1, show_bearing_remove_block);
    positioned_bearing(pos_x, -1, -1, show_bearing_remove_block);
}
// group of 4 positioned bearing

    
module bearings(show_bearing_remove_block) {
    positioned_bearings_group(1, show_bearing_remove_block);
    positioned_bearings_group(-1, show_bearing_remove_block);
}
// create all bearing for one piece


/*
    PIECE
*/
module base_rod_remove_bearing() {
    color([1, 0, 0, 0.7])
    rotate([45, 0, 0])
    cube([base_block_x + 10, rod_remove_side, rod_remove_side], center = true);
}
//base_rod_remove_bearing

module base_rod_remove_holder() {
    color([0, 1, 0, 0.7])
    union() {
        positioned_rod(1, true);
        positioned_rod(-1, true);
    }
}
//base_rod_remove_holder

module base_bearings_remove(bearing_pos_z) {
    positioned_bearing( 1,  1, bearing_pos_z, true);
    positioned_bearing(-1, -1, bearing_pos_z, true);
    positioned_bearing( 1, -1, bearing_pos_z, true);
    positioned_bearing(-1,  1, bearing_pos_z, true);
}
//base_bearings_remove

module base_separator_remove() {
    color([1, 0, 0, 0.7])
    translate([0, base_block_pos_y, 0])
    cube([base_block_x + 10, base_block_y + 10, pieces_spacing], center = true);
}
//base_separator_remove

module base_block_remove_lither() {
    color([1, 0, 0, 0.7])
    translate([0, base_block_pos_y, 0])
    cube([base_block_remove_x, base_block_remove_y + 1, base_block_remove_z], center = true);
    
    echo("piece inside x :", base_block_remove_x);
    echo("motor holder thickness :", (base_block_z - base_block_remove_z) / 2, "mm");
}
//base_block_remove_lither

module base_screw_remove_fixation(pos_x, pos_z) {
	screw_height = 50;
	nut_x = 50;
	
	color([1, 0, 0, 0.7])
	union() {
		translate([((nut_x / 2) - (screws_nuts_side_min / 2) - 1) * pos_x, 0, 0])
		cube([nut_x, screws_nuts_side_min, screw_nuts_height], center = true);
		translate([0, 0, ((screw_height / 2) - (screw_nuts_height / 2) - screw_exceed) * pos_z])
		cylinder (r=(screw_diameter / 2), h=screw_height , center=true);
	}
}
//base_screw_remove_fixation



module positioned_base_screw_remove_fixation(pos_x, pos_y, pos_z, dispSize) {
	fixation_offset_x = 5;
	fixation_offset_y = 12;
	fixation_offset_z = max(motor_holder_thickness, 4);
	
	fixation_x_outside = ((base_block_x / 2) - fixation_offset_x) * pos_x;
	fixation_x_inside = ((base_block_remove_x / 2) + fixation_offset_x) * pos_x;
	fixation_y = base_block_pos_y + (((base_block_y / 2) - fixation_offset_y) * pos_y);
	fixation_z = ((base_block_z / 2) - (screw_nuts_height / 2) - fixation_offset_z) * pos_z;
	
	//fixation_x = ((base_block_x / 2) - fixation_offset_x) * pos_x;
	//fixation_y = 10 * pos_y;
	//fixation_z = (base_block_z / 2) - fixation_offset_z;
	
	translate([fixation_x_outside, fixation_y, fixation_z])
	base_screw_remove_fixation(1 * pos_x, pos_z);
	
	translate([fixation_x_inside, fixation_y, fixation_z])
	base_screw_remove_fixation(-1 * pos_x, pos_z);
	
	if(dispSize) {
		echo("fixation x", abs(fixation_x_outside - fixation_x_inside));
		
		fixation_y_1 = base_block_pos_y + (((base_block_y / 2) - fixation_offset_y) * 1);
		fixation_y_2 = base_block_pos_y + (((base_block_y / 2) - fixation_offset_y) * -1);
		
		echo("fixation y", abs(fixation_y_2 - fixation_y_1));
	}
}
//positioned_base_screw_remove_fixation

module base_screws_remove_fixation() {
	positioned_base_screw_remove_fixation( 1,  1,  1);
	positioned_base_screw_remove_fixation( 1, -1,  1);
	positioned_base_screw_remove_fixation(-1,  1,  1);
	positioned_base_screw_remove_fixation(-1, -1,  1);
	positioned_base_screw_remove_fixation( 1,  1, -1);
	positioned_base_screw_remove_fixation( 1, -1, -1);
	positioned_base_screw_remove_fixation(-1,  1, -1);
	positioned_base_screw_remove_fixation(-1, -1, -1, true);
}
//base_screws_remove_fixation

module positioned_base_screw_remove_tighten(pos_x, pos_y) {
    base_screw_remove_tighten_x_outside = (base_block_x / 2) - (screw_virtual_holder_side / 2);
    base_screw_remove_tighten_x_inside = (base_block_remove_x / 2) + (screw_virtual_holder_side / 2);
    base_screw_remove_tighten_y = (base_block_y / 2) - (screw_virtual_holder_side / 2);
    
   
    translate([0, base_block_pos_y, 0])
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


module base_screws_remove_tighten() {
    positioned_base_screw_remove_tighten( 1,  1);
    positioned_base_screw_remove_tighten( 1, -1);
    positioned_base_screw_remove_tighten(-1,  1);
    positioned_base_screw_remove_tighten(-1, -1);
}
// base_screws_remove_tighten

module motor_holder_screws(pos_x) {
    translate([30 * pos_x, 10, 0])
    screw();
    
    translate([30 * pos_x, 40, 0])
    screw();
}
//motor_holder_screws

module positioned_motor_holder_screws() {
    translate([0, base_block_pos_y - (base_block_y / 2), 0])
    color([1, 0, 0, 0.7])
    union() {
        motor_holder_screws(1);
        motor_holder_screws(-1);
    }
  
}
// positioned_motor_holder_screws


module base_block() {
    color([1, 1, 0, 0.7])
    translate([0, base_block_pos_y, 0])
    cube([base_block_x, base_block_y, base_block_z], center = true);
    echo("piece x :", base_block_x);
    echo("piece y :", base_block_y);
    echo("piece z :", base_block_z);
}


/*
    TEST
*/

module _test_screw_fixer() {
    box_height = 10;
	scale([1, 1, 0.5])
    difference() {
        translate([0, 0, box_height / 2])
        cube([10, 10, box_height], center = true);
        base_screw_remove_tighten();
    }
}

module _test_screw_fixer2() {
    box_height = 10;
	
    difference() {
        translate([0, 0, box_height / 2])
        cube([10, 10, box_height], center = true);
		screw();
		
		echo(screws_nuts_side_min);
		translate([0, 0, box_height / 2])
		cube([11, screws_nuts_side_min, screw_nuts_height], center = true);
    }
}

// to test if screws and nuts sizes are correct for your printer

/*
    RENDERING
*/


module piece(piece_top) {
    difference() {
        base_block();
        base_rod_remove_bearing(); 
        base_rod_remove_holder();
        base_separator_remove();
        base_block_remove_lither();
        if(piece_top != 0) {
            base_bearings_remove(piece_top);
        }
        base_screws_remove_tighten();
		base_screws_remove_fixation();
        positioned_motor_holder_screws();
    }
}

module _render(cube_pos_z) {
    cube_size = 1000;
    if(cube_pos_z == 0) {
        rods(show_rods);
        bearings(false);
        //bearings(true);
        piece(cube_pos_z);
    } else {  
        difference() {
            piece(cube_pos_z);
            translate([0, 0, -(cube_size / 2) * cube_pos_z])
            cube([cube_size, cube_size, cube_size], center = true);
        }
    }
}


_render(0); // -1 for bottom, 0, for all, 1 for top
//_test_screw_fixer();
//_test_screw_fixer2();










