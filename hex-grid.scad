module hex(diameter, thickness, depth) {
    difference() {
        cylinder(d=diameter,h=depth,$fn=6);
        translate([0,0,-0.1]) cylinder(d=diameter - thickness * 2,h=depth + 0.2,$fn=6);
    }
}



module hex_grid(diameter, thickness, depth, rows, columns) {
    outer_radius = diameter / 2;
    inner_radius = outer_radius - thickness;

    x_delta = (outer_radius + inner_radius) * 0.5 * (1 + cos(60));

    y_delta = (outer_radius + inner_radius) * 0.5 * sin(60);

    union() {
        for (r=[0:1:rows - 1]) {
            translate([0, 2 * y_delta * r, 0]) {
                for (c=[0:2:columns - 1]) {
                    translate([x_delta * c, 0, 0]) hex(diameter, thickness, depth);
                }

                for (c=[1:2:columns - 1]) {
                    translate([x_delta * c, y_delta, 0]) hex(diameter, thickness, depth);
                }
            }
        }
    }
}
