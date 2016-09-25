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