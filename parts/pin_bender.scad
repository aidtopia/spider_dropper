// Pin bending tool for Slightly Smarter circuit.
// Bend leads of TO-220AB package (like MOSTFET) to lie horizontally on board.
// Bend leads of resistors and diodes to PCB spacing

module pin_bender() {
    body_l      = 15.24;  // including tab
    body_w      = 10.54;
    body_th     = 4.69;

    hole_offset = 16.6;  // from center of bent pins to center of tab hole
    hole_d      = 3.54;

    pin_l       = 14.09;
    pin_upper_w = 1.40;
    pin_upper_l = 4.06;
    pin_lower_w = 0.93;
    pin_th      = 0.55;
    pin_spacing = 2.54;
    pin_offset  = 2.64;

    bend_r = 2;  // bend radius for leads

    tool_w = max(body_w + 6, 20);
    tool_l = body_l + pin_upper_l + pin_th;
    tool_th = 10;
    tool_r = 2;  // rounding of corners
    grip_l = 12;
    grip_th = 2;
    axial_l = 7.6;  // lead spacing for resistors and diodes
    axial_d = 2.7;  // approximate diameter of resistors and diodes
    resistor_l = 6.5;

    post_th = pin_offset + pin_th;
    post_d = hole_d - 0.1;

    module grip() {
        difference() {
            linear_extrude(grip_th, convexity=8) {
                offset(r=-tool_r, $fn=24) offset(delta= tool_r)
                offset(r= tool_r, $fn=24) offset(delta=-tool_r)
                    polygon([
                        [ tool_w/2, 0],
                        [ tool_w/2, tool_l],
                        [ axial_l/2, tool_l + 1/3*grip_l],
                        [ axial_l/2, tool_l +     grip_l],
                        [-axial_l/2, tool_l +     grip_l],
                        [-axial_l/2, tool_l + 1/3*grip_l],
                        [-tool_w/2, tool_l],
                        [-tool_w/2, 0]
                    ]);
            }
            translate([0, tool_l + 2/3*grip_l, grip_th]) rotate([0, 90, 0]) {
                cylinder(d=axial_d, h=resistor_l, center=true, $fn=24);
            }
        }
    }

    module tool() {
        intersection() {
            linear_extrude(tool_th, convexity=8) {
                translate([-tool_w/2, 0]) {
                    offset(r=tool_r, $fn=24) offset(delta=-tool_r)
                        square(tool_w, tool_l);
                }
            }
            
            rotate([0, 90, 0]) linear_extrude(tool_w+1, center=true) {
                hull() {
                    translate([-tool_th+bend_r, bend_r]) circle(r=bend_r, $fn=24);
                    translate([-1, 0]) square(1);
                    translate([-1, tool_l-1]) square(1);
                    translate([-tool_th, tool_l-1]) square(1);
                }
            }
        }
        grip();
    }

    module cavity() {
        translate([0, pin_upper_l, -pin_offset]) {
            linear_extrude(body_th+1, scale=1.1, convexity=8) {
                translate([-body_w/2, -1]) square([body_w, body_l+1]);
            }
        }
    }
    
    module post() {
        linear_extrude(post_th, scale=0.9) circle(d=post_d, $fn=24);
    }
    
    module channel() {
        channel_w1 = 2*pin_spacing + pin_upper_w + 0.2;
        channel_w2 = 2*pin_spacing + pin_lower_w + 0.2;
        linear_extrude(pin_th + 1, scale=1.2) {
            translate([0, pin_upper_l]) {
                polygon([
                    [-channel_w1/2, 0],
                    [-channel_w1/2, -pin_upper_l],
                    [-channel_w2/2, -pin_upper_l-1],
                    [-channel_w2/2, -pin_l],
                    [ channel_w2/2, -pin_l],
                    [ channel_w2/2, -pin_upper_l-1],
                    [ channel_w1/2, -pin_upper_l],
                    [ channel_w1/2, 0]            
                 ]);
            }
        }
    }

    difference() {
        tool();
        translate([0, pin_th, tool_th-pin_th]) {
            cavity();
            for (theta = [0:15:90]) {
                s = sin(theta)*(bend_r/2);
                c = cos(theta)*(bend_r/2);
                translate([0, c, -s]) rotate([theta, 0, 0]) channel();
            }
        }
    }

    translate([0, hole_offset, tool_th-post_th]) post();
}

pin_bender();
