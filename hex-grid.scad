module hex(diameter, thickness) {
    difference() {
        circle(d=diameter,$fn=6);
        circle(d=diameter - thickness * 2,$fn=6);
    }
}


function compute_x_delta(outer_radius,inner_radius) = (outer_radius + inner_radius) * 0.5 * (1 + cos(60));
function compute_y_delta(outer_radius,inner_radius) = (outer_radius + inner_radius) * 0.5 * sin(60);


module hex_grid(diameter, thickness, rows, columns) {
    outer_radius = diameter / 2;
    inner_radius = outer_radius - thickness;

    x_delta = compute_x_delta(outer_radius,inner_radius);

    y_delta = compute_y_delta(outer_radius,inner_radius);

    union() {
        for (r=[0:1:rows - 1]) {
            translate([0, 2 * y_delta * r, 0]) {
                for (c=[0:2:columns - 1]) {
                    translate([x_delta * c, 0, 0]) hex(diameter, thickness);
                }

                for (c=[1:2:columns - 1]) {
                    translate([x_delta * c, y_delta, 0]) hex(diameter, thickness);
                }
            }
        }
    }
}
