$fn=100;

bearing_outer_diameter = 10.2;
bearing_height = 4;

belt_pulley_inner_diameter_thickness = 1;
belt_pulley_inner_diameter = bearing_outer_diameter + (belt_pulley_inner_diameter_thickness * 2);
belt_pulley_outer_diameter = 18;
belt_pulley_inner_height   = 6.5;
belt_pulley_outer_height   = 9.5;


belt_pulley_border_height  = (belt_pulley_outer_height - belt_pulley_inner_height) / 2;


module belt_pulley_border() {
    color([1, 1, 0, 0.7])
    translate([0, 0, (belt_pulley_outer_height / 2) - (belt_pulley_border_height / 2)])
    cylinder (r1=(belt_pulley_inner_diameter / 2), r2=(belt_pulley_outer_diameter / 2), h=belt_pulley_border_height , center=true);
}



module base_piece() {
    union() {
        color([1, 1, 0, 0.7])
        cylinder (r=(belt_pulley_inner_diameter / 2), h=belt_pulley_outer_height - (belt_pulley_border_height * 2) , center=true);
        belt_pulley_border();
        mirror([0, 0, 1])
        belt_pulley_border();
    }
}

module base_piece_remove() {
    union() {
        // part to remove to be able to insert the bearing
        translate([0, 0, bearing_height / 2])
    color([1, 0, 0, 0.7])
        cylinder (r=(bearing_outer_diameter / 2), h=(bearing_height*2) , center=true);
        
        // part remaining to remove
    color([1, 0, 0, 0.7])
        cylinder (r=(bearing_outer_diameter / 2) - 1, h=belt_pulley_outer_height+ 1, center=true);
    }
}


module _render() {
    difference() {
        base_piece();
        base_piece_remove();
    }
}

    // the bearing
//color([1, 0, 1, 0.7])
//cylinder (r=(bearing_outer_diameter / 2), h=bearing_height, center=true);

_render();

