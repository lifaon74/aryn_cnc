$fn=20;

include <./config.scad>

base_z = 15;
nut_z = base_z - 3;

module foot_base() {
	difference() {
		color([1, 1, 0, 0.7])
		cylinder(h = base_z, r1 = (25 / 2), r2 = (20 / 2), $fn=100, center = true);
		
		translate([0, 0, (base_z / 2)])
		cylinder(r=(nut_diameter_m6 / 2), h=(nut_z * 2) , $fn=6, center=true);
	}
}

foot_base();
