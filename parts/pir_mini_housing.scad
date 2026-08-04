// Mini PIR sensor housing
// Adrian McCarthy 2023-2026

// * Fits _most_ HC-SR312 mini PIR motion sensor modules.
// * The sensor cavity is shaped to orient the sensor consistently.
// * The cap screws over the sensor to hold it securely in place and
// to keep the lens array (the white plastic dome) in place.
// * Slots in the housing accommodate zip-ties for mounting to posts
//   or rails.
// * The back of the housing is threaded for a cable gland with
//   strain relief.  (I designed for glands marked "PG7", but the
//   threading was actually M12x1.5, which is now the default.  You
//   can select `gland="PG7"` to get threads that should mate with
//   a true PG7 gland.)
// * The regular cap allows the dome to protrude from the end of the
//   housing for maximum sensing area.
// * The longer cap slightly restricts the angle of the detection
//   cone but provides some protection to the plastic dome.
// * The "snoot" is a cap with a small aperture for when you want to
//   drastically restrict the detection cone.
// * To reduce the sensor's range, remove the lens array and/or
//   cover the opening of the cap/snoot with one or two layers of
//   cellophane tape.
//
// Print in PETG or PLA.
// I recommend a layer height of 0.2mm (0.15mm for CORE One) to get
// threads that fit well.

use <aidthread.scad>

module PIR_housing(cap="all", gland="M12", nozzle_d=0.4) {
    th = 2;
    lens_d = 12.5;
    lip_d  = 14.2;
    lip_th = 0.4;
    neck_d = 10.75;
    neck_l = 3.8;
    neck_flat = neck_d - 3;

    // Some modules don't have the pcb board exactly inline with the back
    // of the sensor. The notch accommodates this board offset.
    notch_d = neck_d + 2;
    notch_th = 3;
    notch_l = 13;
    
    // Some modules also have the connector offset, so we also need a
    // cavity for the connector.
    conn_extent = 6;  // to one side from center of module
    conn_w = 8;
    conn_h = 29;  // back of connector to lip

    cable_d = 5;
    cap_thread_d = 18;
    cap_thread_pitch = 1.5;
    cap_thread_l = 4*cap_thread_pitch;

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

    assert(gland == "PG7" || gland == "M12");
    gland_thread_d     = gland == "PG7" ? pg7_thread_d     : m12_thread_d;
    gland_thread_pitch = gland == "PG7" ? pg7_thread_pitch : m12_thread_pitch;
    gland_thread_l     = gland == "PG7" ? pg7_thread_l     : m12_thread_l;
    gland_inclusion    = gland == "PG7" ? pg7_inclusion    : m12_inclusion;

    sensor_l = 15;
    connector_l = 14;
    shell_h = gland_thread_l + connector_l + sensor_l + th;
    shell_d = max(cap_thread_d, gland_thread_d) + 2*(th + nozzle_d);
    body_h = shell_h + cap_thread_l;
    reducer_d1 = gland_thread_d + nozzle_d;
    reducer_d2 = neck_flat + nozzle_d;
    reducer_h = reducer_d1 - reducer_d2;  // 45 deg angle
    ziptie_w  = 5 + nozzle_d;
    ziptie_th = 1.5;
    ziptie_dy = (cap_thread_d - ziptie_th)/2 - nozzle_d;
    ziptie_dz = (shell_h + cap_thread_l)/2;
    zip_r = 15;
    cap_l = cap_thread_l + th;  // minimum cap length
    snoot_l = cap_l + 9;
    snoot_aperture = 3;

    $fs=nozzle_d/2;

    module hex_footprint() {
        offset(1) offset(delta=-1) circle(d=shell_d, $fn=6);
    }
    
    module gland_marking() {
        // Center the text between the gland opening and a flat side of
        // the hexagonal shell.
        half_width = shell_d*cos(30)/2;
        opening_r = gland_thread_d/2;
        text_size = half_width - opening_r - 2*nozzle_d;
        rotate([0, 0, 60]) {
            translate([0, (opening_r + half_width)/2, -0.1]) {
                linear_extrude(0.4) mirror([1, 0, 0]) {
                    text(gland, size=text_size,
                         halign="center", valign="center",
                         font="Liberation Sans:style=Bold");
                }
            }
        }
    }

    module body() {
        difference() {
            union() {
                // hexagonal shell
                linear_extrude(shell_h) hex_footprint();
                // threaded top
                translate([0, 0, shell_h])
                    AT_threads(cap_thread_l, cap_thread_d, cap_thread_pitch,
                               tap=false, nozzle_d=nozzle_d);
            }
            // internal threads for the cable gland
            translate([0, 0, -0.01])
                AT_threads(gland_thread_l+0.01, gland_thread_d,
                           gland_thread_pitch, tap=true,
                           inclusion_angle=gland_inclusion,
                           nozzle_d=nozzle_d);
            // reducer (cone-shaped to enable printing w/o supports)
            translate([0, 0, gland_thread_l-0.01])
                cylinder(h=reducer_h, d1=reducer_d1, d2=reducer_d2);
            // cavity for board
            translate([0, 0, gland_thread_l]) {
                linear_extrude(body_h+2, convexity=4) {
                    intersection() {
                        circle(d=neck_d + nozzle_d);
                        square([neck_d+nozzle_d, neck_flat], center=true);
                    }
                }
            }
            // notch for offset boards
            translate([0, 0, body_h-lip_th-notch_l]) {
                linear_extrude(notch_l+1) {
                    square([notch_d, notch_th], center=true);
                }
            }
            // cavity for the neck
            translate([0, 0, body_h-lip_th-neck_l]) {
                cylinder(h=neck_l+1, d=neck_d+nozzle_d);
            }
            // cavity for offset connector
            translate([0, 0, body_h-lip_th-conn_h]) {
                linear_extrude(conn_h+1) {
                    intersection() {
                        translate([-conn_w/2, 0]) square([conn_w, conn_extent]);
                        circle(d=lip_d+nozzle_d);
                    }
                }
            }

            // recess for the lip of the lens
            translate([0, 0, body_h-lip_th])
                cylinder(h=lip_th+1, d=lip_d+nozzle_d);
            
            // Slot for attaching with a perpendicular zip tie.
            translate([0, ziptie_dy, ziptie_dz]) {
                rotate([90, 0, 90]) {
                    linear_extrude(shell_d, center=true) {
                        translate([-ziptie_th/2,-ziptie_w/2]) {
                            polygon([
                                [0, 0],
                                [ziptie_th, 0],
                                [ziptie_th, ziptie_w],
                                [0, ziptie_w+ziptie_th]
                            ]);
                        }
                    }
                }
            }
            
            // Slot for attaching with a parallel zip tie.
            translate([0, -shell_d+ziptie_th, ziptie_dz]) {
                rotate([0, 90, 0]) {
                    rotate_extrude(angle=180, convexity=4, $fa=3) {
                        translate([zip_r, 0]) {
                            square([ziptie_th, ziptie_w+nozzle_d], center=true);
                        }
                    }
                }
            }

            gland_marking();
        }
    }
    
    module cap(extra=0) {
        cap_h = cap_l + extra;
        difference() {
            linear_extrude(cap_h) hex_footprint();
            translate([0, 0, cap_h-cap_thread_l+0.1])
                AT_threads(cap_thread_l, cap_thread_d, cap_thread_pitch, tap=true,
                        nozzle_d=nozzle_d);
            translate([0, 0, -1])
                cylinder(h=cap_h+1, d=lens_d+nozzle_d);
        }
    }

    // A version of a cap with a small aperture to dramatically limit
    // the angle of the cone of detection.
    module snoot(aperture_d=3) {
        difference() {
            linear_extrude(snoot_l) hex_footprint();
            translate([0, 0, snoot_l-cap_thread_l+0.1])
                AT_threads(cap_thread_l, cap_thread_d, cap_thread_pitch, tap=true,
                           nozzle_d=nozzle_d);
            d = lens_d + nozzle_d;
            translate([0, 0, th])
                cylinder(h=snoot_l, d=d);
            translate([0, 0, -1])
                cylinder(h=snoot_l, d=aperture_d+nozzle_d);
        }
    }
    
    module radial_translate(angle, distance=1) {
        translate([distance*cos(angle), distance*sin(angle), 0]) {
            children();
        }
    }

    body();
    spacing = shell_d + 1;
    if (cap == "all" || cap == "short") {
        radial_translate(210, spacing) cap();
    }
    if (cap == "all" || cap == "tall") {
        radial_translate( 90, spacing) cap(6);
    }
    if (cap == "all" || cap == "snoot") {
        radial_translate(150, spacing) snoot(snoot_aperture);
    }
}

PIR_housing();
