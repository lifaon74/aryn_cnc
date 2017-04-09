$fn=20;

/*
    PIECE
*/

module vacuum_test() {
	$fn=100;
	
	vacuum_diameter_inner = 25+2;
	vacuum_diameter_outer = 24;
	
	color([0.1, 0.1, 0.1])
	translate([0, 0, 0])
	difference() {
		cylinder(r=(vacuum_diameter_inner / 2), h=10, center=true);
		cylinder(r=(vacuum_diameter_inner / 2) - 1, h=11, center=true);
	}
	
//	cylinder(r1=(vacuum_diameter_inner / 2), r2 = (vacuum_diameter_inner / 2) - 1, h=10, center=true);
	
	
}
// vacuum_test
vacuum_test();


