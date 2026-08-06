// Cable Gland Wrench
// Adrian McCarthy 2026
//
// A wrench for tightening and loosening PG7 and M12 cable glands.  Also
// serves as a thread gauge for those sizes.

use <aidthread.scad>

// These are the correct PG7 values.  The PG7-marked glands I used to
// use were actually M12.
pg7_thread_d     = 12.5;
pg7_thread_pitch = 1.27;
pg7_thread_l     = 5.25*pg7_thread_pitch;
pg7_inclusion    = 80;

m12_thread_d     = 12;
m12_thread_pitch = 1.5;
m12_thread_l     = 4.5*m12_thread_pitch;
m12_inclusion    = 60;

module wrench(nozzle_d=0.4) {
    wall_th = 5;
    sides = 6;  // hexagonal
    flat_to_flat = 15.5;  // measured
    corner_r = 2;  // measured
    handle_l = 60;
    handle_w = max(pg7_thread_d, m12_thread_d) + wall_th;
    th = 4.4;
    label_size = 4.5;

    interior_angle = 360 / sides;
    half_angle = interior_angle/2;
    ff = flat_to_flat;
    f = ff/2;
    r = f / cos(half_angle);
    id = 2*r;
    echo(str("wrench id: ", id));
    od = id + 2*wall_th;
    side_l = 2*r*sin(half_angle);

    $fs=nozzle_d;

    difference() {
        linear_extrude(th, convexity=8) {
            translate([0, (handle_l+od)/2]) {
                rotate([0, 0, half_angle/2]) intersection() {
                    difference() {
                        circle(d=od, $fa=3);
                        offset(r=corner_r, $fn=30) offset(delta=-corner_r) {
                            rotate([0, 0, half_angle]) circle(d=id, $fn=sides);
                        }
                        translate([0, f]) square(ff, center=true);
                    }
                    union() {
                        hull() {
                            rotate([0, 0, half_angle]) {
                                translate([r+wall_th/2, 0]) {
                                    circle(d=wall_th, $fn=30);
                                }
                            }
                            difference() {
                                circle(d=od, $fa=3);
                                translate([0, (od+f)/2]) square(od, center=true);
                            }
                        }
                        hull() {
                            rotate([0, 0, (sides-1)*half_angle]) {
                                translate([r+wall_th/2, 0]) {
                                    circle(d=wall_th, $fn=30);
                                }
                            }
                            difference() {
                                circle(d=od, $fa=3);
                                translate([0, (od+f)/2]) square(od, center=true);
                            }
                        }
                    }
                }

                // Beef up the connection between the head and the handle.
                difference() {
                    dy = -wall_th;
                    width_at_dy = 2*sqrt((od/2)*(od/2) - dy*dy);
                    hull() {
                        translate([0, dy]) {
                            square([width_at_dy, 0.1], center=true);
                        }
                        translate([0, -(od/2 + wall_th)]) {
                            square([handle_w, wall_th], center=true);
                        }
                    }
                    circle(d=id);
                }
            }


            hull() {
                translate([0, handle_l/2+wall_th/2]) {
                    square([handle_w, wall_th], center=true);
                }
                translate([0, -(handle_l/2+wall_th/2)]) {
                    circle(d=handle_w);
                }
            }
        }

        translate([0, -(pg7_thread_d/2 + 1.5*label_size), 0]) {
            AT_threads(h=th, d=pg7_thread_d, pitch=pg7_thread_pitch,
                       inclusion_angle=pg7_inclusion, tap=true,
                       nozzle_d=nozzle_d);
            translate([0, 3*nozzle_d + pg7_thread_d/2, th-0.5]) {
                linear_extrude(1) {
                    text("PG7", size=label_size,
                         halign="center", valign="bottom", spacing=1.2,
                         font="Liberation Sans:style=Bold");
                }
            }
        }
        translate([0, m12_thread_d/2 + 1.5*label_size, 0]) {
            AT_threads(h=th, d=m12_thread_d, pitch=m12_thread_pitch,
                       inclusion_angle=m12_inclusion, tap=true,
                       nozzle_d=nozzle_d);
            translate([0, 3*nozzle_d + m12_thread_d/2, th-0.5]) {
                linear_extrude(1) {
                    text("M12", size=label_size,
                         halign="center", valign="bottom", spacing=1.2,
                         font="Liberation Sans:style=Bold");
                }
            }
        }
    }


//    #offset(r=corner_r, $fn=30) offset(delta=-corner_r) {
//        rotate([0, 0, half_angle]) circle(d=id, $fn=sides);
//    }

        
}


wrench();
