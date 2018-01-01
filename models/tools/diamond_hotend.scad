include <./e3d_v6.scad>

$fn=40;

e3d_v6_radiator_diameter_margin = 0.25;
e3d_v6_fix_diameter_margin = 0.25;



module diamon_hot_end_genuine() {
	color([1, 0, 0])
	translate([-30, 0, 63])
	import("./diamon_hotend_base.stl");
}
// diamon_hot_end_genuine

module positioned_e3d_v6(mode = "default", e3d_v6_radiator_diameter_margin = 0, e3d_v6_fix_diameter_margin = 0) {
	translate([12.69, 0, 25.332])
	rotate([0, 28, 0])
	e3d_v6(mode, e3d_v6_radiator_diameter_margin, e3d_v6_fix_diameter_margin);
}
// positioned_e3d_v6

module positioned_e3d_v6_all(mode = "default", e3d_v6_radiator_diameter_margin = 0, e3d_v6_fix_diameter_margin = 0) {
	
	for(a = [0 : 1 : 2]) {	
		rotate([0, 0, 120 * a])
		positioned_e3d_v6(mode, e3d_v6_radiator_diameter_margin, e3d_v6_fix_diameter_margin);
	}
}
// positioned_e3d_v6_all

module diamon_hot_end(mode = "default", e3d_v6_radiator_diameter_margin = 0, e3d_v6_fix_diameter_margin = 0) {
	
	positioned_e3d_v6_all(mode, e3d_v6_radiator_diameter_margin, e3d_v6_fix_diameter_margin);
}
// diamon_hot_end

module diamon_hot_end_plenty() {
	diamon_hot_end("plenty", e3d_v6_radiator_diameter_margin, e3d_v6_fix_diameter_margin);
}
// diamon_hot_end_plenty

//diamon_hot_end();
//diamon_hot_end_plenty();