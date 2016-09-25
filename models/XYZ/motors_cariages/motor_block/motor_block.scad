$fn=100;

screw_diameter = 3;
material_thickness = 3;

motor_renforcement_thickness = 3;
motor_side = 42;
motor_screws_spacing = 31; // space between the screws fixing the motor

motor_pinion_diameter = 25; // min 22

bearing_holder_type = 1; // 1 or 2
bearing_holder_attach_height = 10.5;

motor_virtual_height = 60 - 15;
motor_center_y = 15 + (motor_virtual_height / 2);


module bearing_holder() {
    linear_extrude(height=material_thickness)
    polygon([
        [0, 0],
        [20, 0],
        [35, 15],
        [35, 25],
        [25, 25],
        [25, 20],
        [15, 10],
        [0, 10]
    ]);
}


module bearing_holder_half(type) {
    difference() {
        union() {
            
            bearing_holder();
            
            
            if(bearing_holder_type == 1) {
                translate([0, 5, (bearing_holder_attach_height / 2) + material_thickness])
                cube([8, 10, bearing_holder_attach_height], center=true);
                translate([30, 20, (bearing_holder_attach_height / 2) + material_thickness])
                cube([10, 10, bearing_holder_attach_height], center=true);
            } else {
            
                translate([15, 5, (bearing_holder_attach_height / 2) + material_thickness])
                cube([10, 10, bearing_holder_attach_height], center=true);
            }
        }
        
        bearing_holder_screws_remove();
    }
}
// motor_block_half


module screw() {
    screw_height = 50;
    cylinder (r=(screw_diameter / 2), h=screw_height , center=true);
}
// a screw

module bearing_holder_screws_remove() {
    color([1, 0, 0, 0.7])
    union() {
        translate([0, 5, 0])
        screw();

        translate([15, 5, 0])
        screw();

        translate([30, 20, 0])
        screw(); 
    }
}
// the screw holes to hold the bearing support

module motor_remove() {
    color([1, 0, 0, 0.7])
    union() {
        translate([0, motor_center_y, 0])
        cylinder (r=(motor_pinion_diameter / 2), h=50 , center=true);


        motor_screws_offset = motor_screws_spacing / 2;
        translate([motor_screws_offset, motor_center_y + motor_screws_offset, 0])
        screw();

        translate([motor_screws_offset, motor_center_y - motor_screws_offset, 0])
        screw();
    }
}
// the holes to fix the motor

module motor_holder() {
    linear_extrude(height=material_thickness)
    polygon([
        [0, 0],
        [20, 0],
        [35, 15],
        [35, 25],
        [25, 25],
        [25, 60],
        [0, 60]
    ]);
}
// motor_holder

module motor_renforcement() {
    translate([25, 15, material_thickness])
    rotate([0, -90, 0])
    color([1, 0, 1])
    linear_extrude(height=motor_renforcement_thickness)
    polygon([
        [0, material_thickness],
        [motor_virtual_height, material_thickness],
        [0, motor_virtual_height]
    ]);
}
// motor_renforcement

module motor_attach_screw_remove() {
    translate([30, 15, 10 + material_thickness])
    rotate([90, 0, 0])
    screw();

    translate([30, 15, 40 + material_thickness])
    rotate([90, 0, 0])
    screw();
    
    screw_nut_height = 5;
    screw_nut_diameter = 7;
    translate([30, 20, (screw_nut_height / 2) + material_thickness])
    cylinder(r=screw_nut_diameter / 2, h=screw_nut_height , center=true);
}
// motor_attach_screw_remove
//motor_attach_screw_remove();

 module motor_attach() {
    difference() {
        translate([25 - motor_renforcement_thickness, 15, material_thickness])
        color([0, 1, 0])
        cube([10 + motor_renforcement_thickness, material_thickness, motor_virtual_height]);
        
        motor_attach_screw_remove();
    }
}
// motor_attach




module motor_block_half() {
    difference() {
        union() {
            motor_holder();
            motor_renforcement();
            motor_attach();
        } 
        
        motor_remove();
        bearing_holder_screws_remove();
    }
}
// motor_block_half

module motor() {
    color([0.7, 0.7, 0.7])
    translate([0, motor_center_y, (motor_side / 2) + material_thickness])
    cube([motor_side, motor_side, motor_side], center=true);
}



module _render(piece_to_render) {
    if(piece_to_render == "all") {
        motor();
    }
    
    if((piece_to_render == "all") || (piece_to_render == "base")) {
         union() {
             motor_block_half();
             mirror([1, 0, 0])
             motor_block_half();
         }
    }
    
    if(piece_to_render == "bearing_holder") {
        union() {
            bearing_holder_half();
            mirror([1, 0, 0])
            bearing_holder_half();
        }
    }
}

// 'all' | 'base' | bearing_holder
//_render("bearing_holder");
_render("base");






