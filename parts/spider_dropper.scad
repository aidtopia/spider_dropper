// Stupidly Simple Spider Dropper
// Adrian McCarthy 2023-02-25

// The assembly is mounted overhead.  A string secured to the spool
// holds a toy spider.  A slow motor turns the big gear, which winds
// the spool, raising the spider.  When the toothless section of the
// drive gear comes around, the winder becomes free wheeling, and the
// weight of the spider will cause the spool to unwind rapidly (the
// drop).  When the teeth again engage, the spider will climb back up.

// How far the prop should drop.
Drop_Distance = 24; // [1:100]

// Units for Drop Distance.
Drop_Distance_Units = "inch"; // ["inch", "mm", "cm"]

// Select your motor type.  The FrightProps and MonsterGuts motors are identical. Other deer motors will work only if they always turn clockwise.
Motor = "Aslong JGY-370 12 VDC Worm Gearmotor"; // ["FrightProps Deer Motor", "MonsterGuts Mini-Motor", "Aslong JGY-370 12 VDC Worm Gearmotor"]

Include_Base_Plate = true;
Include_Drive_Gear = true;
Include_Spool_Assembly = true;
Include_Button = false;
Include_PCB_Cradle = false;

module __Customizer_Limit__ () {}

use <aidgear.scad>
use <honeycomb.scad>

function inch(x) = x * 25.4;
function thou(x) = inch(x/1000);

function round_up(n, base=1) =
    n % base == 0 ? n : floor((n+base)/base)*base;

function nut_diameter(nut_w, nut_sides=6, nozzle_d=0.4) =
    nozzle_d +
    ((nut_sides % 2) == 0 ?
        round_up(nut_w / cos(180/nut_sides), nozzle_d) :
        nut_w);

m3_free_d = 3.6;
m3_head_d = 6.0;
m3_head_h = 2.4;
m3_flange_d = 7.0;
m3_flange_h = 0.7;
m3_nut_w = 5.5;
m3_nut_h = 2.4;
m4_free_d = 4.5;
m4_head_d = 8.0;
m4_head_h = 3.1;
no6_free_d = thou(149.5);
no6_head_d = thou(262);
no6_sink_h = thou(83);
bearing608_od = 22;
bearing608_id = 8;
bearing608_th = 7;
    
// Key dimensions for "reindeer" motors like those sold by FrightProps
// and MonsterGuts.  These are 5-6 RPM synchronous AC motors in a weather
// resistant housing.
deer_shaft_d = 7.0;
deer_shaft_af = 5.5;  // across flats
deer_shaft_h = 6.2;
deer_shaft_screw = "M4";  // machine screw
deer_shaft_screw_l = 10;
// The base is a circular area around the shaft that rises above the
// mounting face of the motor.
deer_base_d = 21;  // at the face plate.  Tapers down to 17.
deer_base_h = 5;
deer_mounting_screw = "M3 self-tapping";  // a #6 would fit
deer_mounting_screw_l = 12;
deer_mounting_screw_head_d = m3_flange_d;
deer_mounting_screw_head_h = m3_head_h + m3_flange_h;
deer_mounting_screw_free_d = m3_free_d;
deer_mount_dx1 = 81;  // separation between mounting screws nearest the hub
deer_mount_dx2 = 57;
deer_mount_dy1 = 17; // hub to dx1 line
deer_mount_dy2 = 35 + deer_mount_dy1; // hub to dx2 line
deer_w = 90;
deer_l = 90;
deer_h = 37.6;

// Key dimensions for the Aslong JGY-370 DC gearmotors (and look alikes).
jgy_shaft_d = 6.0;
jgy_shaft_flat = 0.5;
jgy_shaft_h = 14;
jgy_shaft_screw = "M3";  // machine screw
jgy_shaft_screw_l = 8;
jgy_base_d = 13.2;
jgy_base_h = 0;
jgy_mounting_screw = "M3";
jgy_mounting_screw_l = 4;
jgy_mounting_screw_head_d = m3_head_d;
jgy_mounting_screw_head_h = m3_head_h;
jgy_mounting_screw_free_d = m3_free_d;
jgy_mount_dx1 = 18;
jgy_mount_dx2 = 18;
jgy_mount_dy1 = -9;
jgy_mount_dy2 = 33 + jgy_mount_dy1;
jgy_w = 32;
jgy_l = 81;
jgy_h = 27;

function lerp(t, x0=0, x1=1) = x0 + t*(x1 - x0);
function mid(x0, x1) = lerp(0.5, x0, x1);

module deer_motor_spline(h=1, nozzle_d=0.4) {
    // The shaft of the deer motor is a cylinder with two flattened
    // faces.
    shaped_h = min(h, deer_shaft_h);
    translate([0, 0, -0.1]) {
        linear_extrude(shaped_h+0.2, convexity=10) {
            intersection() {
                circle(d=deer_shaft_d+nozzle_d/2, $fs=nozzle_d/2);
                square([deer_shaft_d+nozzle_d/2, deer_shaft_af+nozzle_d/2],
                       center=true);
            }
        }
        // If the desired height is taller than the shaft itself, we'll
        // cap the flattened portion so there's something to tighten the
        // hub screw against.
        passthru_h = min(h-shaped_h, 2);
        if (passthru_h > 0) {
            translate([0, 0, shaped_h]) {
                linear_extrude(passthru_h+0.2, convexity=10) {
                    circle(d=m4_free_d+nozzle_d, $fs=nozzle_d/2);
                }
            }
            // If there's still more height, we'll make a simple hole to
            // recess the head of the hub screw.
            remainder_h = h - shaped_h - passthru_h;
            if (remainder_h > 0) {
                translate([0, 0, shaped_h + passthru_h]) {
                    linear_extrude(remainder_h+0.2, convexity=10) {
                        circle(d=m4_head_d+nozzle_d, $fs=nozzle_d/2);
                    }
                }
            }
        }
    }
}

module jgy_motor_spline(h=1, nozzle_d=0.4) {
    module flattened_shaft(clearance=nozzle_d/2) {
        intersection() {
            circle(d=jgy_shaft_d+clearance, $fs=nozzle_d/2);
            translate([jgy_shaft_flat, 0, 0])
                square([jgy_shaft_d, jgy_shaft_d+clearance], center=true);
        }
    }
    
    translate([0, 0, -0.1]) {
        // The shaft of the JGY motor has one flattened side.
        shaped_h = min(h, jgy_shaft_h);
        linear_extrude(shaped_h+0.2, convexity=4) {
            flattened_shaft();
        }
        linear_extrude(2, convexity=4, scale=0.95) {
            scale(1/0.95) flattened_shaft();
        }
        // If the desired height is taller than the shaft itself, we'll
        // cap the flattened portion so there's something to tighten the
        // hub screw against.
        passthru_h = min(h-shaped_h, 2);
        if (passthru_h > 0) {
            translate([0, 0, shaped_h]) {
                linear_extrude(passthru_h+0.2, convexity=10) {
                    circle(d=m4_free_d+nozzle_d, $fs=nozzle_d/2);
                }
            }
            // If there's still more height, we'll make a simple hole to
            // recess the head of the hub screw.
            remainder_h = h - shaped_h - passthru_h;
            if (remainder_h > 0) {
                translate([0, 0, shaped_h + passthru_h]) {
                    linear_extrude(remainder_h+2, convexity=10) {
                        circle(d=m4_head_d+nozzle_d, $fs=nozzle_d/2);
                    }
                }
            }
        }
    }
}

module circular_arrow(r, theta0=0, theta1=360, th=1) {
    dir = sign(theta1 - theta0);
    function circumference(r) = 2*PI*r;
    function theta_at(v) = theta1 - v * dir * 360 / circumference(r);
    function polar(r, theta) = r*[cos(theta), sin(theta)];
    function p(u, v) = polar(r+u, theta_at(v));
    facet_count =
        $fn > 0 ? $fn
                : round(max($fa > 0 ? 360/$fa : 30,
                            circumference(r) / ($fs > 0 ? $fs : 2)));
    dtheta = dir * 360 / facet_count;

    arrowhead_w = 4*th;
    arrowhead_l = 3*arrowhead_w;
    
    // The "neck" is approximately where the head meets the tail.
    theta_base = theta_at(arrowhead_l-th);
    theta_neck = dtheta * floor(theta_base / dtheta);
    step = 1 / round(facet_count * arrowhead_l / circumference(r));

    polygon([
        each [for (theta=[theta0:dtheta:theta_neck]) polar(r+th/2, theta)],
        each [if (theta_base != theta_neck) polar(r+th/2, theta_base)],
        each [for (t=[0:step:1])
                p(lerp(t, arrowhead_w/2, 0), lerp(t, arrowhead_l, 0))],
        each [for (t=[0:step:1])
                p(lerp(t, 0, -arrowhead_w/2), lerp(t, 0, arrowhead_l))],
        each [if (theta_base != theta_neck) polar(r-th/2, theta_base)],
        each [for (theta=[theta_neck:-dtheta:theta0]) polar(r-th/2, theta)],
        each [if (theta0 % dtheta != 0) polar(r-th/2, theta0)]
    ]);
}

// Cuts out the insides of a 2D object (or objects) and leaving an
// outline of the perimeter(s).
module outline(th=1) {
    difference() {
        offset(max(th, 0.0001)) children();
        offset(min(th, 0)) children();
    }
}

// Works like difference (for 2D) but adds back outlines of the shapes
// that were cut away.
module cutaway(outline=1) {
    difference() {
        if ($children > 0) children(0);
        if ($children > 1) children([1:$children-1]);
    }
    if ($children > 1) outline(outline) children([1:$children-1]);
}

module sector(r=1, sweep=30) {
    intersection() {
        circle(r=r);
        polygon([
            [0, 0],
            [2*r*cos(sweep), 2*r*sin(sweep)],
            [2*r, 0]
        ]);
    }
}

module spider_dropper(drop_distance=inch(24), motor="deer", nozzle_d=0.4) {
    $fs = nozzle_d/2;

    string_d = 2;

    motor_w = max(deer_w, jgy_w);
    motor_h = max(deer_h, jgy_h);
    motor_base_d = max(deer_base_d, jgy_base_d);
    motor_base_h = max(deer_base_h, jgy_base_h);
    motor_screw_head_h =
        max(deer_mounting_screw_head_h, jgy_mounting_screw_head_h);
    motor_shaft_h =
        max(deer_base_h + deer_shaft_h, jgy_base_h + jgy_shaft_h);
    motor_shaft_d = max(deer_shaft_d, jgy_shaft_d);

    min_th = 3*nozzle_d;
    wall_th = 2*min_th;
    plate_th = min_th + motor_screw_head_h;

    gear_th = bearing608_th;

    // This is the model for the drive gear, which is connected directly
    // to the motor shaft.
    model = AG_define_gear(
        iso_module=1.5,
        tooth_count=57,
        thickness=gear_th,
        helix_angle=15,
        herringbone=false,
        name="drive gear"
    );

    // The actual drive gear has teeth 4/5 of the way around and is
    // toothless on the remaining fifth.  We use helical teeth for
    // smooth, quiet operation and durability.  Herringbone teeth
    // jam if there is even a slight misalignment when the teeth
    // re-engage after passing the depopulated portion.  Helical
    // gears are more forgiving.
    drive_teeth = AG_tooth_count(model);
    actual_drive_teeth = ceil(4/5 * drive_teeth);
    drive =
        AG_depopulated_gear(model, [actual_drive_teeth+1:drive_teeth]);
    AG_echo(drive);

    // The top of the drive gear must be at least min_th above the top
    // of the motor shaft.  That's going to be the reference for the
    // heights of everything else in the gear train.
    drive_z1 = motor_shaft_h + min_th;
    drive_z0 = drive_z1 - AG_thickness(drive);
    // The bottom of the collar that extends below the drive gear
    // around the motor shaft to enclose most of the flattened part of
    // the shaft.
    drive_collar_z = motor_base_h+1;
    drive_collar_d =
        min(max(mid(motor_shaft_d, motor_base_d), motor_shaft_d+6*nozzle_d),
            motor_base_d - nozzle_d);
    drive_collar_h = drive_z0 - drive_collar_z;

    // The drive gear turns the winder gear, which is attached to the
    // spool.  The winder gear is slightly thicker to create some
    // clearance between the spool and the drive gear.
    winder = AG_define_gear(
        tooth_count=19,
        thickness=AG_thickness(drive)+min_th,
        mate=drive
    );
    winder_z0 = drive_z0;
    winder_z1 = winder_z0 + AG_thickness(winder);
    
    assert(AG_root_diameter(winder) > bearing608_od + 3*nozzle_d);

    dx = AG_center_distance(drive, winder);

    spool_turns = actual_drive_teeth / AG_tooth_count(winder);
    spool_d = drop_distance / (spool_turns * PI);  // to bottom of groove
    spool_flange_d = spool_d + string_d*spool_turns;
    spool_h = 2*bearing608_th - AG_thickness(winder);
    spool_z0 = winder_z1;
    spool_z1 = spool_z0 + spool_h;

    assert(spool_d > 2*bearing608_od);

    axle_l = 2*bearing608_th + nozzle_d;
    axle_d = bearing608_id;

    button_d = 5*string_d;
    
    spacer_h = drive_z0 - plate_th;
    spacer_d = axle_d + 3;
    plate_l =
        wall_th +
        AG_tips_diameter(drive)/2 + dx + spool_flange_d/2 +
        wall_th;
    plate_xoffset = -plate_l/2 + plate_th/2 + AG_tips_diameter(drive)/2;
    plate_w =
        wall_th +
        max(AG_tips_diameter(drive), spool_flange_d, motor_w) +
        wall_th;
    plate_yoffset = 0;
    plate_r = 10;
    
    guide_th = wall_th;
    guide_h = plate_th + spacer_h + AG_thickness(winder) + spool_h/2;
    guide_base_w = 10*string_d;
    guide_base_h = plate_th;
    guide_d = 5*string_d;

    // Mounting bolt holes for both motors.
    // [0] = [x, y] position
    // [1] = head diameter
    // [2] = head height
    // [3] = free diameter
    mounting_holes = [
        [[-jgy_mount_dx1/2, -jgy_mount_dy1],   jgy_mounting_screw_head_d,  jgy_mounting_screw_head_h, jgy_mounting_screw_free_d],
        [[ jgy_mount_dx1/2, -jgy_mount_dy1],   jgy_mounting_screw_head_d,  jgy_mounting_screw_head_h, jgy_mounting_screw_free_d],
        [[-jgy_mount_dx2/2, -jgy_mount_dy2],   jgy_mounting_screw_head_d,  jgy_mounting_screw_head_h, jgy_mounting_screw_free_d],
        [[ jgy_mount_dx2/2, -jgy_mount_dy2],   jgy_mounting_screw_head_d,  jgy_mounting_screw_head_h, jgy_mounting_screw_free_d],
        [[-deer_mount_dx1/2, -deer_mount_dy1], deer_mounting_screw_head_d, deer_mounting_screw_head_h, deer_mounting_screw_free_d],
        [[ deer_mount_dx1/2, -deer_mount_dy1], deer_mounting_screw_head_d, deer_mounting_screw_head_h, deer_mounting_screw_free_d],
        [[-deer_mount_dx2/2, -deer_mount_dy2], deer_mounting_screw_head_d, deer_mounting_screw_head_h, deer_mounting_screw_free_d],
        [[ deer_mount_dx2/2, -deer_mount_dy2], deer_mounting_screw_head_d, deer_mounting_screw_head_h, deer_mounting_screw_free_d]
    ];

    // The "slightly smarter" version uses a small PCB that attaches to
    // the motor side of the build plate.  These dimensions must match
    // those used in the PCB layout.
    pcb_w = 20;
    pcb_l = 80;
    pcb_th = 1.6;
    cradle_w = pcb_w + 2*min_th;
    cradle_l = pcb_l + 2*min_th;  // doesn't include screw tabs
    cradle_th = min_th + pcb_th;
    cradle_yoffset = jgy_w/2 + cradle_w/2 + min_th;
    cradle_nut_d = nut_diameter(m3_nut_w, 6, nozzle_d=nozzle_d);
    cradle_boss_d = cradle_nut_d + 2*min_th;
    cradle_boss_xoffset = (cradle_l - cradle_boss_d)/2;
    cradle_boss_yoffset = (cradle_w + min_th + m3_free_d)/2;

    module drive_gear() {
        difference() {
            union() {
                translate([0, 0, drive_z0]) {
                    difference() {
                        AG_gear(drive);
                        translate([0, 0, AG_thickness(drive)])
                            linear_extrude(1, center=true)
                                circular_arrow(0.35*AG_tips_diameter(drive), 160, 20);
                    }
                }
                translate([0, 0, drive_collar_z]) {
                    cylinder(h=drive_collar_h+0.1, d=drive_collar_d, $fs=nozzle_d/2);
                }
                translate([0, 0, drive_collar_z]) {
                    last_tooth = actual_drive_teeth - 1;
                    advance = 2;  // stop 2 drive teeth before the drop
                    degrees_to_switch = -90;
                    rpm = 6;
                    seconds_to_hold = 1;
                    sweep = 360 * rpm / 60 * seconds_to_hold;
                    linear_extrude(drive_collar_h) {
                        rotate([0, 0, 360*(last_tooth - advance)/drive_teeth + degrees_to_switch])
                        sector(r=AG_root_diameter(drive)/2-2, sweep=sweep, $fa=2);
                    }
                }
            }
            if (motor == "jgy") {
                jgy_motor_spline(drive_z1, nozzle_d=nozzle_d);
            } else if (motor == "deer") {
                translate([0, 0, deer_base_h])
                deer_motor_spline(drive_z1, nozzle_d=nozzle_d);
            }
        }
    }

    module spool_assembly() {
        module spool() {
            module pocket() {
                module input(nudge=0) {
                    rotate([0, 90, 0])
                        translate([0, 0, nudge])
                            linear_extrude(spool_d/2, convexity=4)
                                rotate([0, 0, 45])
                                    square(string_d, center=true);
                }
                module output(nudge=0) {
                    rotate([0, -45, 0])
                        translate([0, 0, nudge])
                        linear_extrude(spool_h, convexity=4)
                            rotate([0, 0, 45])
                                square(string_d, center=true);
                }
                
                translate([spool_d/2-plate_th, 0, spool_h/2]) {
                    rotate([0, 0, -45]) {
                        input();
                        output();
                        intersection() {
                            input(nudge=-(1+cos(45))*string_d);
                            output(nudge=-(1+cos(45))*string_d);
                        }
                    }
                }
            }

            difference() {
                rotate_extrude(convexity=10, $fa=5) {
                    r0 = 0;
                    r1 = spool_flange_d/2;
                    r2 = spool_d/2;
                    y0 = 0;
                    y1 = spool_h;
                    y2 = y1 - (r1-r2);
                    y3 = y0 + (r1-r2);
                    polygon([
                        [r0, y0],
                        [r0, y1],
                        [r1, y1],
                        [r2, y2],
                        [r2, y3],
                        [r1, y0]
                    ]);
                }
                // The string is secured to the spool in the pocket.
                pocket();
                translate([0, 0, spool_h])
                    linear_extrude(2, convexity=6, center=true)
                        circular_arrow(0.35*spool_flange_d, 100, 260);
            }
        }

        module winder_gear() {
            AG_gear(winder);
        }
   
        translate([0, 0, plate_th+spacer_h]) {
            difference() {
                union() {
                    winder_gear();
                    translate([0, 0, AG_thickness(winder)]) {
                        spool();
                    }
                }
                translate([0, 0, -1]) {
                    linear_extrude(spool_h + AG_thickness(winder) + 2) {
                        circle(d=bearing608_od);
                    }
                }
                // Beveling to make it easier to insert the bearings.
                translate([0, 0, AG_thickness(winder)+spool_h-1]) {
                    cylinder(h=2, d1=bearing608_od, d2=bearing608_od + 2);
                }
                translate([0, 0, -1]) {
                    cylinder(h=2, d1=bearing608_od + 2, d2=bearing608_od);
                }
            }
        }
    }
    
    // The button is for tying off the string at the spool.
    module button() {
        linear_extrude(string_d, convexity=6) {
            difference() {
                $fs=nozzle_d/2;
                circle(d=button_d);
                translate([-button_d/5, 0]) circle(d=string_d + nozzle_d);
                translate([ button_d/5, 0]) circle(d=string_d + nozzle_d);
            }
        }
    }

    module axle() {
        // This generates the spacer, which rises through the base plate,
        // the axle itself, the chamfer at the top, a hollow space inside
        // that makes the axle stronger because it generates more
        // perimeters, and a conical indentation at the top end for
        // alignment and support from and upper plate.
        recess_d = 4;
        recess_h = recess_d/2;
        chamfer = 1;
        z0 = 0;
        z1 = z0 + plate_th;
        z2 = z1 + spacer_h;
        z3 = z2 + axle_l;
        z4 = z3 + chamfer;
        r0 = 0;
        r3 = r0 + axle_d/2;
        r1 = r3 - 4*nozzle_d;
        r2 = r0 + recess_d/2;
        r4 = z0 + spacer_d/2;
        r5 = r4 + plate_th/2;
        points = [
            [r0, z0],
            [r0, mid(z0, z1)],
            [r1, mid(z0, z1) + (r1 - r0)],
            [r1, z4 - recess_h - 1 - (r1 - r0)/2],
            [r0, z4 - recess_h - 1],
            [r0, z4 - recess_h],
            [r2, z4],
            [r3-chamfer, z4],
            [r3, z3],
            [r3, z2],
            [r4, z2],
            [r4, z1],
            [r5, z1],
            [r5, z0]
        ];
        rotate_extrude(convexity=4) polygon(points);
    }

    module guide(th=guide_th, h=guide_h, base_w=guide_base_w, base_h=guide_base_h, id=string_d, od=guide_d, nozzle_d=0.4) {
        rotate([90, 0, 0]) {
            translate([0, 0, th/2]) difference() {
                linear_extrude(th, center=true) {
                    difference() {
                        hull() {
                            circle(d=od);
                            translate([-base_w/2, -h])
                                square([base_w, base_h]);
                        }
                    }
                }
                rotate_extrude(convexity=4) {
                    hole_th = th + nozzle_d;
                    hole_d = id + nozzle_d;
                    difference() {
                        translate([0, -hole_th/2])
                            square([hole_d, hole_th]);
                        translate([hole_d, 0])
                            circle(d=hole_d);
                    }
                }
            }
        }
    }
    
    module base_plate() {
        module footprint() {
            offset(plate_r) offset(-plate_r)
                square([plate_l, plate_w], center=true);
        }

        translate([0, 0, plate_th/2]) {
            difference() {
                linear_extrude(plate_th, convexity=8, center=true) {
                    cutaway(outline=-2*min_th) {
                        cutaway(outline=min_th) {
                            union() {
                                translate([plate_xoffset, plate_yoffset, 0]) {
                                    bounded_honeycomb(plate_l, plate_w, 14,
                                                      min_th, center=true) {
                                        footprint();
                                    }
                                    outline(-wall_th) footprint();
                                }
                                // add bosses for the motor mounting screws
                                rotate([0, 0, -90]) {
                                    for (hole=mounting_holes) {
                                        translate(hole[0]) {
                                            offset(min_th) circle(d=hole[1]+nozzle_d);
                                        }
                                    }
                                }
                                // bosses for PCB cradle
                                translate([-cradle_boss_xoffset, cradle_yoffset + cradle_boss_yoffset]) {
                                    circle(d=cradle_boss_d);
                                }
                                translate([cradle_boss_xoffset, cradle_yoffset - cradle_boss_yoffset]) {
                                    circle(d=cradle_boss_d);
                                }
                            }
                            // cutaways
                            circle(d=motor_base_d+nozzle_d);
                            rotate([0, 0, -90]) {
                                for (hole=mounting_holes) {
                                    translate(hole[0]) circle(d=hole[3]+nozzle_d);
                                }
                            }
                            translate([-cradle_boss_xoffset, cradle_yoffset + cradle_boss_yoffset]) {
                                circle(d=m3_free_d + nozzle_d);
                            }
                            translate([cradle_boss_xoffset, cradle_yoffset - cradle_boss_yoffset]) {
                                circle(d=m3_free_d + nozzle_d);
                            }
                            translate([0, cradle_yoffset]) {
                                square([cradle_l, cradle_w], center=true);
                            }
                        }
                        translate([0, cradle_yoffset]) {
                            square([cradle_l, cradle_w], center=true);
                        }
                    }
                }

                // recess the mounting screws
                rotate([0, 0, -90]) {
                    for (hole=mounting_holes) {
                        translate([hole[0][0], hole[0][1], plate_th-hole[2]]) {
                            linear_extrude(plate_th, center=true) {
                                circle(d=hole[1] + nozzle_d);
                            }
                        }
                    }
                }
                translate([-cradle_boss_xoffset, cradle_yoffset+cradle_boss_yoffset, plate_th-m3_nut_h-min_th]) {
                    linear_extrude(plate_th, center=true) {
                        circle(d=cradle_nut_d+nozzle_d, $fn=6);
                    }
                }
                translate([cradle_boss_xoffset, cradle_yoffset-cradle_boss_yoffset, plate_th-m3_nut_h-min_th]) {
                    linear_extrude(plate_th, center=true) {
                        circle(d=cradle_nut_d+nozzle_d, $fn=6);
                    }
                }
            }
        }
        translate([-dx, 0]) axle();
        translate([-dx, plate_w/2, guide_h]) guide(nozzle_d=nozzle_d);
    }

    module cradle() {
        module cradle_envelope() {
            square([cradle_l, cradle_w], center=true);
        }
        module pcb_footprint() {
            cut = 3 - nozzle_d/2;
            l = -(pcb_l/2 + nozzle_d/2);
            r =   pcb_l/2 + nozzle_d/2;
            t =   pcb_w/2 + nozzle_d/2;
            b = -(pcb_w/2 + nozzle_d/2);
            difference() {
                polygon([
                    [l, b+cut],
                    [l, t-cut],
                    [l+cut, t],
                    [r, t],
                    [r, b],
                    [l+cut, b]
                ]);
                translate([pcb_l/2 - 24, -pcb_w/2]) circle(r=3-nozzle_d/2);
            }
        }
        
        module screw_tab() {
            difference() {
                hull() {
                    difference() {
                        circle(d=cradle_boss_d);
                        translate([0, -cradle_boss_d/2])
                            square(cradle_boss_d, center=true);
                    }
                    translate([0, -m3_free_d/2])
                        square([cradle_boss_d, min_th], center=true);
                }
                circle(d=m3_free_d + nozzle_d);
            }
        }
        
        linear_extrude(min_th) {
            difference() {
                cradle_envelope();
                offset(-min_th) square([pcb_l, pcb_w], center=true);
            }
        }
        linear_extrude(cradle_th) {
            difference() {
                cradle_envelope();
                pcb_footprint();
            }
            translate([-cradle_boss_xoffset, cradle_boss_yoffset]) {
                screw_tab();
            }
            translate([cradle_boss_xoffset, -cradle_boss_yoffset]) {
                rotate([0, 0, 180]) screw_tab();
            }
        }
    }

    show_assembled = $preview;
    
    if (Include_Base_Plate) base_plate();

    if (Include_Drive_Gear) {
        t = show_assembled ?
            [0, 0, 0] :
            [plate_xoffset+AG_tips_diameter(drive)/2+1, plate_yoffset+(plate_w+AG_tips_diameter(drive))/2+1, drive_z1];
        r = show_assembled ? [0, 0, 0] : [180, 0, 0];
        translate(t) rotate(r) drive_gear();
    }

    if (Include_Spool_Assembly) {
        t = show_assembled ?
            [-dx, 0, 0] :
            [plate_xoffset-(spool_flange_d+2)/2, plate_yoffset+(plate_w+spool_flange_d)/2+1, spool_h + AG_thickness(winder) + plate_th + spacer_h];
        r = show_assembled ? [0, 0, 0] : [180, 0, 0];
        translate(t) rotate(r) spool_assembly();
    }

    if (Include_Button) {
        t = show_assembled ?
            [-dx + spool_d/4, spool_d/4, plate_th + spacer_h + AG_thickness(winder) + spool_h] :
            [plate_xoffset-button_d/2, plate_yoffset+(plate_w+button_d)/2+1, 0];
        translate(t) button();
    }
    
    if (Include_PCB_Cradle) {
        t = show_assembled ?
            [0, cradle_yoffset, -cradle_th] :
            [dx + cradle_boss_d + 2, 0, 0];            
        r = show_assembled ? [0, 0, 0] : [0, 0, -90];
        translate(t) rotate(r) cradle();
    }

    if (!$preview) {
        echo(str(
            "\nPRINTING INSTRUCTIONS\n",
            "\nExport the model and slice it with a 0.2 mm or 0.3 mm layer\n",
            "height using at least 3 perimeters.  Print it with your choice\n",
            "of material.  It has been tested with PLA and PETG.\n"
        ));
        
        if (motor == "deer") {
            echo(str(
                "\nASSEMBLY INSTRUCTIONS\n",
                "\nUnscrew the arm from the motor shaft. Keep the hub\n",
                "screw. If you need to replace it, use an M4 x 10 mm\n",
                "machine screw.\n",
                "\nUnscrew the four elevated screws from the perimeter\n",
                "of the motor housing. Those are M3 x 10 mm self-tapping\n",
                "screws.\n",
                "\nAttach the motor to the back of the plate with the\n",
                "shaft poking through the center of the large hole.  You\n",
                "can re-use the perimeter screws or substitute longer\n",
                "ones. I used M3 x 16 mm self-tapping screws with flanges\n",
                "just under the heads.\n",
                "\nAlign the shaped hole on the drive gear with the end of\n",
                "the motor shaft and press it into place. The clockwise\n",
                "arrow should be facing away from the plate. Secure the\n",
                "gear with the M4 hub screw you removed at the beginning.\n",
                "\nTest the motor by applying power and making sure the\n",
                "gear turns clockwise, as indicated by the arrow, and that\n",
                "it doesn't rub against the plate. If the gear turns\n",
                "counterclockwise or if it changes direction when the\n",
                "motion is impeded, it will not work with this design.\n"
            ));
        }
        if (motor == "jgy") {
            echo(str(
                "\nASSEMBLY INSTRUCTIONS\n",
                "\nAttach the motor to the back of the plate with the\n",
                "shaft poking through the largest hole. Secure the motor\n",
                "with four M3 x 6 mm machine screws. If the shaft isn't\n",
                "quite at right angles to the plate, you can make small\n",
                "adjustments by shimming the motor with bits of paper.\n",
                "\nAlign the shaped hole on the drive gear with the end of\n",
                "the motor shaft and press it into place. The clockwise\n",
                "arrow should be facing away from the plate. Secure the\n",
                "gear with an M3 x 10mm machine screw.\n",
                "\nTest the motor by applying power and making sure the\n",
                "gear turns clockwise, as indicated by the arrow, and that\n",
                "it doesn't rub against the plate. If the gear turns\n",
                "counterclockwise, switch the wires connected to the motor\n",
                "and test again.\n"
            ));
        }

        echo(str(
            "\nPress two 608 ball bearings (commonly used in skateboard\n",
            "wheels) into the bore of the spool assembly.  They should fit\n",
            "tightly and be flush with the top and bottom of the spool\n",
            "assembly.\n",
            "\nFeed the end of the string through the small hole in the\n",
            "guide on the plate.  Then feed the same end through the small\n",
            "hole in the groove of the spool.  It will emerge on top of the\n",
            "spool.  Tie the end through the button.\n",
            "\nHold the spool assembly with the gear section over the head\n",
            "of the plastic axle on the plate. The arrow should be facing\n",
            "away from the plate.\n",
            "\nTurn on the motor. When the toothless portion of the drive\n",
            "gear comes around, you should be able to press the spool\n",
            "assembly all the way down the axle. When the teeth come around\n",
            "the spool should begin winding up the string. Apply a little\n",
            "resistance to the string below the guide, so that it wraps\n",
            "around the spool evenly.  When the toothless portion arrives\n",
            "again, you should be able to pull the string and it will\n",
            "unspool.  Repeat until you have a feel for the drop distance.\n",
            "\nTurn off the motor.  Attach your prop to the string at the\n",
            "drop distance below the guide.\n",
            "\nYour prop should not weigh more than 1 pound (about 0.5 kg).\n",
            "\nEnsure the string doesn't get tangled or wrapped around the\n",
            "prop when it drops.\n"
        ));
    }
}

drop_distance =
    Drop_Distance_Units == "inch" ? inch(Drop_Distance) :
    Drop_Distance_Units == "mm"   ? Drop_Distance :
    Drop_Distance_Units == "cm"   ? 10*Drop_Distance : Drop_Distance;

motor =
    Motor == "FrightProps Deer Motor" ? "deer" :
    Motor == "MonsterGuts Mini-Motor" ? "deer" :
    Motor == "Aslong JGY-370 12 VDC Worm Gearmotor" ? "jgy" : "none";

spider_dropper(drop_distance=drop_distance, motor=motor);
