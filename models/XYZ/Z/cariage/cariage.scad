$fn=20;

include <../../config.scad>

show_screws     = true;
show_bearings   = true;
show_rods       = true;

rod_x = 20.4; // sqrt(2) * rod_side

base_bearing_holder_z = 2;
screw_virtual_holder_side_smaller = 8;

bearing_center_x = bearing_outer_diameter + (bearing_holder_spacing_2 * 2);
 
 
base_x = rod_x + (screw_virtual_holder_side * 2);
base_y = base_block_z;
base_z = (bearing_center_x * 2) + (screw_virtual_holder_side_smaller * 2) + base_bearing_holder_z;

bearing_pos = (bearing_outer_diameter + rod_side) / (2 * sqrt(2));

lead_screw_outer_diameter = 22;
lead_screw_inner_diameter = 10.2; // 10
lead_screw_height = 11; // 10
lead_screw_fix_screw_diameter = 16.2;
lead_screw_fix_screw_pos = (lead_screw_fix_screw_diameter / 2) / sqrt(2);

echo("base_z", base_z);
 
/*
    RODS
*/

module positioned_rod() {
    rotate([0, 90, 0])
    rod(true);
}
// positioned_rod
//positioned_rod();


/*
    BEARINGS
*/
module bearing(show_bearing_remove_block) {
    if(show_bearing_remove_block) {
            // sizes
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
//	(rod_horizontal_spacing / 2)
    translate([pos_x * bearing_pos, pos_y * bearing_pos, pos_z * ((bearing_center_x / 2) + (base_bearing_holder_z / 2))])
    rotate([0, 0, 45 * pos_x * pos_y])
    bearing(show_bearing_remove_block);
}
// position one bearing
    
module bearings(show_bearing_remove_block) {
    positioned_bearing(+1, +1, +1, show_bearing_remove_block);
	positioned_bearing(-1, -1, +1, show_bearing_remove_block);
	positioned_bearing(-1, +1, +1, show_bearing_remove_block);
	positioned_bearing(+1, -1, +1, show_bearing_remove_block);
	
	positioned_bearing(+1, +1, -1, show_bearing_remove_block);
	positioned_bearing(-1, -1, -1, show_bearing_remove_block);
	positioned_bearing(-1, +1, -1, show_bearing_remove_block);
	positioned_bearing(+1, -1, -1, show_bearing_remove_block);
}
// create all bearing for one piece
//bearings(true);

/*
    PIECE
*/

module positioned_base_screw_remove_tighten(pos_x, pos_z) {
    base_screw_remove_tighten_x = (base_x / 2) - (screw_virtual_holder_side / 2);
	base_screw_remove_tighten_z = (base_z / 2) - (screw_virtual_holder_side_smaller / 2);
	
    translate([0, 0, pos_z * base_screw_remove_tighten_z])
    union() {
        translate([pos_x * base_screw_remove_tighten_x, 0, 0])
        rotate([90, -45 * pos_x * pos_z, 0])
        base_screw_remove_tighten();
    }
}
// positioned_base_screw_remove_tighten


module positioned_base_screws_remove_tighten() {
    positioned_base_screw_remove_tighten(+1, +1);
	positioned_base_screw_remove_tighten(-1, +1);
	positioned_base_screw_remove_tighten(+1, -1);positioned_base_screw_remove_tighten(-1, -1);
}
//positioned_base_screws_remove_tighten

module base_screw_remove_fixation(pos_x, pos_y, pos_z) {
	screw_height = 50;
	
	nut_z = 50;
	nut_offset_z = (nut_z / 2) - (screws_nuts_side_min / 2) - 1;
	
	screw_offset_y = (screw_height / 2) - (screw_nuts_height / 2) - screw_exceed;
	
	
	fixation_offset_x = 8;
	fixation_offset_y = -(base_y / 2) + 4;
	fixation_offset_z = (base_z / 2) - (screw_virtual_holder_side_smaller / 2);
	
	
	translate([fixation_offset_x * pos_x, fixation_offset_y * pos_y, fixation_offset_z * pos_z])
	color([1, 0, 0, 0.7])
	
	union() {
		
		translate([0, 0, nut_offset_z * pos_z])
		cube([screws_nuts_side_min, screw_nuts_height, nut_z], center = true);
		
		rotate([90, 0, 0])
		translate([0, 0, screw_offset_y * pos_y])
		cylinder (r=(screw_diameter / 2), h=screw_height , center=true);
		
	}
}
//base_screw_remove_fixation

module positioned_base_screw_remove_fixation() {
	base_screw_remove_fixation(+1, +1, +1);
	base_screw_remove_fixation(+1, -1, +1);
	base_screw_remove_fixation(-1, +1, +1);
	base_screw_remove_fixation(-1, -1, +1);

	base_screw_remove_fixation(+1, +1, -1);
	base_screw_remove_fixation(+1, -1, -1);
	base_screw_remove_fixation(-1, +1, -1);
	base_screw_remove_fixation(-1, -1, -1);
}
// positioned_base_screw_remove_fixation

module base_rod_remove_bearing() {
    color([1, 0, 0, 0.7])
    rotate([45, 90, 0])
    cube([base_z + 10, rod_remove_side, rod_remove_side], center = true);
}
//base_rod_remove_bearing

module base_separator_remove() {
    color([1, 0, 0, 0.7])
    cube([base_x + 100, pieces_spacing, base_z + 10], center = true);
}
//base_separator_remove

module base_block() {
    color([1, 1, 0, 0.7])
//    translate([0, base_block_pos_y, 0])
    cube([base_x, base_y, base_z], center = true);
}




/*
    LEAD SCREW
*/


module lead_screw_fix(pos_x, pos_y) {
	nuts_remove_length = 50;
	
	translate([lead_screw_fix_screw_pos * pos_x, lead_screw_fix_screw_pos * pos_y, 0])
	union() {
		screw();
		
		translate([0, 0, nuts_remove_length / 2])
		rotate([0, 0, -45 * pos_x * pos_y])
		cylinder ($fn = 6, r=(screws_nuts_side_max / 2), h=nuts_remove_length, center=true);
	}
};
// lead_screw_fix

module lead_screw_block() {
	
	lead_screw_nut_height = 3;
	
	difference() {	
		cube([lead_screw_outer_diameter, base_y, lead_screw_height], center = true);
		
		cylinder (r=(lead_screw_inner_diameter / 2), h=lead_screw_height * 2 , center=true);
		
		translate([0, 0, (lead_screw_height / 2) - lead_screw_nut_height])
		union() {
			lead_screw_fix(+1, +1);
			lead_screw_fix(-1, +1);
			lead_screw_fix(+1, -1);
			lead_screw_fix(-1, -1);
		}
	}
	
    
}
// lead_screw_block


/*
    RENDERING
*/


module base_block_spliter() {
	base_block_spliter_y = base_y;
	
	color([0, 0, 1, .7])
	translate([0, -(base_block_spliter_y / 2) - 0.01, 0])
	cube([100, base_block_spliter_y, base_z * 2], center = true);
}
// base_block_spliter


module lead_screw_piece() {
	translate([-(base_x / 2) - (lead_screw_outer_diameter / 2) + 0.01, 0, (base_z / 2) - (lead_screw_height / 2)])
	lead_screw_block();
}
// lead_screw_piece
//lead_screw_piece();

module piece(piece_top) {
    difference() {
		union() {
			difference() {
				base_block();
				
				union() {
					base_rod_remove_bearing();
					bearings(true);
					positioned_base_screws_remove_tighten();
					positioned_base_screw_remove_fixation();
				}
			}
			
			lead_screw_piece();
		}
       
		base_separator_remove();
    }
}

module _render() {
	difference() { // difference, intersection
		piece();
		base_block_spliter();
	}
}


_render();










