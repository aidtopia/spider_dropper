// Representation of JGY-370 motor for visualization.
// Adrian McCarthy 2026-05-30.

module jgy_motor(angle=0) {

    // Key dimensions for the Aslong JGY-370 DC gearmotors (and look alikes).
    jgy_shaft_d = 6.0;
    jgy_shaft_h = 14;
    jgy_base_d = 13.2;
    jgy_base_h = 1.8;
    jgy_mount_screw = "M3";
    jgy_mount_screw_l = 6;
    jgy_mount_screw_depth = 4;
    jgy_mount_h = 2.2;
    jgy_mount_dx1 = 18;
    jgy_mount_dx2 = 18;
    jgy_mount_dy1 = -9;
    jgy_mount_dy2 = 33 + jgy_mount_dy1;
    jgy_w = 32;
    jgy_l = 81;
    jgy_h = 27;
    jgy_motor_d = 24.2;
    jgy_motor_l = 30.7;
    jgy_motor_offset = 31.0;
    jgy_gbox_w = 32.0;
    jgy_gbox_l = 45.8;
    jgy_gbox_h = 24.5 - jgy_base_h;
    jgy_gbox_r = 2;
    jgy_gbox_offset = -jgy_gbox_l + jgy_motor_offset;

    translate([0, 0, -jgy_mount_h]) {
        translate([-jgy_gbox_w/2, -jgy_motor_offset, -jgy_gbox_h]) {
            translate([jgy_gbox_w - jgy_motor_d/2 - 2, -jgy_motor_l, jgy_gbox_h - jgy_motor_d/2 - 1]) rotate([-90, 0, 0])
            cylinder(h=jgy_motor_l, d=jgy_motor_d, $fn=32);

            difference() {
                linear_extrude(jgy_gbox_h, convexity=8) {
                    offset(r=jgy_gbox_r, $fn=12) offset(delta=-jgy_gbox_r)
                        square([jgy_gbox_w, jgy_gbox_l]);
                }
                translate([0, 0, jgy_gbox_h-2-0.1]) linear_extrude(0.1, convexity=8) {
                    difference() {
                        offset(r=jgy_gbox_r+0.1, $fn=12) offset(delta=-jgy_gbox_r)
                            square([jgy_gbox_w, jgy_gbox_l]);
                        offset(r=jgy_gbox_r+0.1, $fn=12) offset(delta=-jgy_gbox_r-0.2)
                            square([jgy_gbox_w, jgy_gbox_l]);
                    }
                }
            }
        }

        linear_extrude(jgy_base_h) {
            circle(d=jgy_base_d, $fn=16);
            hull() {
                translate([-14.8/2, -12]) circle(d=6, $fn=12);
                translate([ 14.8/2, -12]) circle(d=6, $fn=12);
            }
        }

        linear_extrude(jgy_mount_h, convexity=8) {
            difference() {
                union() {
                    translate([-jgy_mount_dx1/2, -jgy_mount_dy1]) circle(d=7.5, $fn=16);
                    translate([ jgy_mount_dx1/2, -jgy_mount_dy1]) circle(d=7.5, $fn=16);
                    translate([-jgy_mount_dx2/2, -jgy_mount_dy2]) circle(d=7.5, $fn=16);
                    translate([ jgy_mount_dx2/2, -jgy_mount_dy2]) circle(d=7.5, $fn=16);
                }
                translate([-jgy_mount_dx1/2, -jgy_mount_dy1]) circle(d=3, $fn=12);
                translate([ jgy_mount_dx1/2, -jgy_mount_dy1]) circle(d=3, $fn=12);
                translate([-jgy_mount_dx2/2, -jgy_mount_dy2]) circle(d=3, $fn=12);
                translate([ jgy_mount_dx2/2, -jgy_mount_dy2]) circle(d=3, $fn=12);
            }
        }

        linear_extrude(jgy_shaft_h) {
            rotate([0, 0, angle]) {
                intersection() {
                    circle(d=jgy_shaft_d, $fn=24);
                    translate([-1, 0]) square(jgy_shaft_d, center=true);
                }
            }
        }
    }
}

jgy_motor();
