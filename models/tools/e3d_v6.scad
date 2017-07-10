// e3d_v6
e3d_v6_height = 42.7;

e3d_v6_radiator_diameter = 22.3;
e3d_v6_radiator_lamella_height = 1;
e3d_v6_radiator_lamella_distance = 2.5;
e3d_v6_radiator_lamella_number = 12;

e3d_v6_fix_diameter_outer = 16;
e3d_v6_fix_diameter_inner= 12;
e3d_v6_fix_top_height = 3.7;
e3d_v6_fix_center_height = 6.0;
e3d_v6_fix_bottom_height = 3.0;

e3d_v6_core_d1 = 14;
e3d_v6_core_d2 = 8;
e3d_v6_core_height = e3d_v6_height - e3d_v6_fix_top_height - e3d_v6_fix_center_height - e3d_v6_fix_bottom_height;


module e3d_v6_fix(margin = 0) {
	
	_e3d_v6_fix_diameter_outer = e3d_v6_fix_diameter_outer + margin * 2;
	_e3d_v6_fix_diameter_inner = e3d_v6_fix_diameter_inner + margin * 2;
	_e3d_v6_fix_top_height = e3d_v6_fix_top_height + margin * 2;
	_e3d_v6_fix_center_height = e3d_v6_fix_center_height + margin * 2;
	_e3d_v6_fix_bottom_height = e3d_v6_fix_bottom_height + margin * 2;
	
	union() {
		translate([0, 0, e3d_v6_fix_bottom_height + e3d_v6_fix_center_height + (e3d_v6_fix_top_height / 2)])
		cylinder(r=(_e3d_v6_fix_diameter_outer / 2), h=_e3d_v6_fix_top_height + 0.01, center=true);
		
		translate([0, 0, e3d_v6_fix_bottom_height + (e3d_v6_fix_center_height / 2)])
		cylinder(r=(_e3d_v6_fix_diameter_inner / 2), h=_e3d_v6_fix_center_height + 0.01, center=true);
		
		translate([0, 0, (e3d_v6_fix_bottom_height / 2)])
		cylinder(r=(_e3d_v6_fix_diameter_outer / 2), h=e3d_v6_fix_bottom_height + 0.01, center=true);
	}
}
// e3d_v6_fix

module e3d_v6_radiator(mode = "default", margin = 0) {
	e3d_v6_radiator_diameter_with_margin = e3d_v6_radiator_diameter + margin * 2;
	if(mode == "plenty") {
		_e3d_v6_radiator_height = e3d_v6_radiator_lamella_distance * e3d_v6_radiator_lamella_number;
		
		translate([0, 0, (_e3d_v6_radiator_height / 2)])
		cylinder(r=(e3d_v6_radiator_diameter_with_margin / 2), h=_e3d_v6_radiator_height, center=true);
	} else {
		union() {
			for(z = [0 : 1 : e3d_v6_radiator_lamella_number - 1]) {
				
				_e3d_v6_radiator_diameter = (z < 11) ? e3d_v6_radiator_diameter_with_margin : e3d_v6_fix_diameter_outer;
				
				translate([0, 0, z * e3d_v6_radiator_lamella_distance + (e3d_v6_radiator_lamella_height / 2)])
				cylinder(r=(_e3d_v6_radiator_diameter / 2), h=e3d_v6_radiator_lamella_height, center=true);
			}
		}
	}
	
}
// e3d_v6_radiator

module e3d_v6(mode = "default", e3d_v6_radiator_diameter_margin= 0, e3d_v6_fix_diameter_margin = 0) {
	union() {
		e3d_v6_radiator(mode, e3d_v6_radiator_diameter_margin);
		
		translate([0, 0, e3d_v6_core_height])
		e3d_v6_fix(e3d_v6_fix_diameter_margin);
		
		translate([0, 0, (e3d_v6_core_height / 2) + 0.01])
		cylinder(r1=(e3d_v6_core_d1 / 2), r2=(e3d_v6_core_d2 / 2), h=e3d_v6_core_height + 0.01, center=true);
	}
}
// e3d_v6