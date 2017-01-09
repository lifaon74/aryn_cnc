$fn=20;

screw_m2_diameter = 2;
//screw_m2_height = 5;
screw_m2_head_diameter = 4;
screw_m2_head_height = 2;
screw_m2_nut_diameter = 5;
screw_m2_nut_height = 10;

//screw_m3_diameter = 3;
//screw_m3_height = 30;
//screw_m3_head_diameter = 6;
//screw_m3_head_height = 10;
//screw_m3_nut_diameter = 6.55;
//screw_m3_nut_height = 10;

screw_m3_diameter = screw_m2_diameter;
screw_m3_height = 30;
screw_m3_head_diameter = screw_m2_head_diameter;
screw_m3_head_height = 10;
screw_m3_nut_diameter = screw_m2_nut_diameter;
screw_m3_nut_height = 10;

// the minium material arougd screw
screw_material_thickness = 2;
screw_material_thickness_stronger = 3;

belt_width = 6.5;
belt_step_space = 2;

// space between parts
base_space = 2;

// computed

screw_m2_height = base_space + (screw_material_thickness * 2);

base_x = belt_width + (screw_m2_nut_diameter * 2);
base_y = 10;
base_bottom_z = screw_m3_nut_diameter + screw_material_thickness;
base_top_z = screw_material_thickness + screw_m2_head_height;
	
belt_step_radius = belt_step_space / 4;

echo("base_x", base_x);
echo("base_y", base_y);
echo("base_bottom_z", base_bottom_z);
echo("base_top_z", base_top_z);
echo("total_z", base_bottom_z + base_top_z + 1);

module screw(
	screw_diameter, screw_height,
	screw_head_diameter, screw_head_height,
	screw_nut_diameter, screw_nut_height
) {
	color([0.2, 0.2, 0.2])
	union() {
		translate([0, 0, (screw_height / 2) + (screw_head_height / 2)])
		cylinder(r=(screw_head_diameter / 2), h=screw_head_height , center=true);
		
		cylinder(r=(screw_diameter / 2), h=(screw_height + 0.1) , center=true);
		
		translate([0, 0, -(screw_height / 2) - (screw_nut_height / 2)])
		cylinder(r=(screw_nut_diameter / 2), h=screw_nut_height, $fn=6 , center=true);
	}
}
//screw

module screw_m2() {
	screw(
		screw_m2_diameter, screw_m2_height,
		screw_m2_head_diameter, screw_m2_head_height + 0.01,
		screw_m2_nut_diameter, screw_m2_nut_height
	);
}
//screw_m2

module screw_m3() {
	screw(
		screw_m3_diameter, screw_m3_height,
		screw_m3_head_diameter, screw_m3_head_height,
		screw_m3_nut_diameter, screw_m3_nut_height
	);
}
//screw_m3

module positioned_screw_m2(pos_x) {
	translate([((belt_width / 2) + (screw_m2_nut_diameter / 2)) * pos_x, 0, (base_space / 2)])
	rotate([0, 0, 30])
	screw_m2();
}
// positioned_screw_m2

module positioned_screw_m3() {
	positioned_screw_m3_offset_z = -(screw_m3_nut_diameter / 2) - screw_material_thickness;
	
	translate([0, (screw_m3_height / 2) + (base_y / 2) - screw_material_thickness_stronger, -(screw_m3_nut_diameter / 2) - screw_material_thickness])
	rotate([-90, 30, 0])
	screw_m3();
	echo("positioned_screw_m3_offset_z", positioned_screw_m3_offset_z);
}
// positioned_screw_m3

module belt_step() {
	rotate([0, 90, 0])
	cylinder(r=belt_step_radius, h=belt_width , center=true);
}
//belt_step

module positioned_belt_step() {
	belt_step_offset = -(base_y / 2) + belt_step_radius;
	
	i = 0;
	end = belt_step_offset + base_y - belt_step_radius;
	for(pos_y = [belt_step_offset : belt_step_space : end]) {
		translate([0, pos_y, 0])
		belt_step();
	}
}
// positioned_belt_step

module base_bottom() {
	translate([0, 0, -(base_bottom_z / 2)])
	cube([base_x, base_y, base_bottom_z], center = true);
}
//base_bottom

module base_top() {
	color([1, 1, 0, 0.7])
	translate([0, 0, (base_top_z / 2) + base_space])
	cube([base_x, base_y, base_top_z], center = true);
}
//base_top

module _render_bottom() {
	color([1, 1, 0, 0.7])
	difference() {
		union() {
			base_bottom();
//			positioned_belt_step();
		}
		
		union() {
			positioned_screw_m3();
			positioned_screw_m2(1);
			positioned_screw_m2(-1);
		}
	}
}
// _render_bottom

module _render_top() {
	color([1, 1, 0, 0.7])
	difference() {
		union() {
			base_top();
			translate([0, 0, 2])
			positioned_belt_step();
		}
		
		union() {
			positioned_screw_m2(1);
			positioned_screw_m2(-1);
		}
	}
}
// _render_top

//_render_top();
_render_bottom();





