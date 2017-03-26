
$fn = 40;

cable_chain_in_x_total = 40;
cable_chain_in_y = 15;
cable_chain_in_z = 25;

cable_chain_thickness_y = 1.5;
cable_chain_thickness_z = 3;

cable_chain_in_x = cable_chain_in_x_total - cable_chain_in_y - (cable_chain_thickness_y * 2);

cable_chain_out_x = cable_chain_in_x;
cable_chain_out_y = cable_chain_in_y + cable_chain_thickness_y * 2;
cable_chain_out_z = cable_chain_in_z + cable_chain_thickness_z * 2;


cable_chaine_clip_radius_in = cable_chain_out_y / 4;
cable_chaine_clip_margin = 0.3;


cable_chaine_clip_radius_out = (cable_chain_out_y / 2);
cable_chain_clip_z = (cable_chain_thickness_z / 2);
	
cable_chain_clip_x_offset = (cable_chain_out_x / 2) + (cable_chain_out_y / 2);
cable_chain_clip_z_offset = (cable_chain_out_z / 2) - cable_chain_clip_z;


cable_chain_lighter_margin_x = 6;
cable_chain_lighter_margin_z = 2;

module cable_chain_clip_male(pos_z) {

	translate([cable_chain_clip_x_offset, 0, cable_chain_clip_z_offset * pos_z])
	union() {
		translate([0, 0, (cable_chain_clip_z / 2) * pos_z])
		cylinder(r=cable_chaine_clip_radius_out, h=cable_chain_clip_z , center=true);
		
		translate([-(cable_chain_out_y / 4), 0, (cable_chain_clip_z / 2) * pos_z])
		cube([cable_chain_out_y / 2, cable_chain_out_y, cable_chain_clip_z], center = true);
		
		translate([0, 0, -(cable_chain_clip_z / 2) * pos_z])
		cylinder(r=cable_chaine_clip_radius_in - (cable_chaine_clip_margin / 4), h=cable_chain_clip_z , center=true);
	}
}
// cable_chain_clip_male


module cable_chain_clip_female(pos_z) {
	translate([-cable_chain_clip_x_offset, 0, cable_chain_clip_z_offset * pos_z])
	difference() {
		union() {
			translate([0, 0, -(cable_chain_clip_z / 2) * pos_z])
			cylinder(r=cable_chaine_clip_radius_out, h=cable_chain_clip_z , center=true);
			
			translate([(cable_chain_out_y / 4), 0, -(cable_chain_clip_z / 2) * pos_z])
			cube([cable_chain_out_y / 2, cable_chain_out_y, cable_chain_clip_z], center = true);
		}
		
		translate([0, 0, -(cable_chain_clip_z / 2) * pos_z])
			cylinder(r=cable_chaine_clip_radius_in + (cable_chaine_clip_margin / 4), h=cable_chain_clip_z * 2 , center=true);
	}
}
// cable_chain_clip_female



module cable_chain_clip() {
	cable_chain_clip_male(+1);
	cable_chain_clip_male(-1);
	cable_chain_clip_female(+1);
	cable_chain_clip_female(-1);
}
// cable_chain_clip



module cable_chain_out() {
	cube([cable_chain_out_x, cable_chain_out_y, cable_chain_out_z], center = true);
}

// cable_chain_out

module cable_chain_in() {
	cube([cable_chain_in_x + 0.01, cable_chain_in_y, cable_chain_in_z], center = true);
}
// cable_chain_in

module cable_chain_lighter() {
	cable_chain_lighter_x = cable_chain_out_x - (cable_chain_lighter_margin_x * 2);
	cable_chain_lighter_y = cable_chain_out_y * 2;
	
	cable_chain_lighter_z = cable_chain_in_z - (cable_chain_lighter_margin_z * 2);
	cube([cable_chain_lighter_x, cable_chain_lighter_y, cable_chain_lighter_z], center = true);
}
// cable_chain_lighter


module cable_chain() {
	
	
	
	difference() {
		union() {
			cable_chain_out();
			cable_chain_clip();
		}
		
		cable_chain_in();
		cable_chain_lighter();
	}
}


cable_chain();


offset_chain = (cable_chain_out_x / 2) + (cable_chain_out_y / 2);

translate([offset_chain, offset_chain, 0])
rotate([0, 0, 90])
cable_chain();