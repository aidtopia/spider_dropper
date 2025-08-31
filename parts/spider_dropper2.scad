// Stupidly Simple Spider Dropper
// Adrian McCarthy 2023-02-25

// 2025-08-16:
// This is an experimental redesign based on the idea of putting the
// gears out farther from the base plate than the spool.  I'm hoping
// this makes it possible to better secure the drive gear to the
// motor shaft.  It should also reduce the torque caused by the
// hanging weight, since that'll extend fom closer to the center of
// mass.

// The assembly is hung overhead.  A string secured to the spool
// passes through the guide and holds a toy spider.  A slow motor
// turns the big gear, which winds the spool, raising the spider.
// When the toothless section of the drive gear comes around, the
// winder becomes free wheeling, and the weight of the spider
// will cause the spool to unwind rapidly (the drop).  When the
// teeth again engage, the spider will climb back up.

// How far the prop should drop (in inches)?
Drop_Distance = 24; // [14, 18, 24, 30, 36]

// For the AC version, we use a "deer" motor.  These are 5 or 6 RPM
// synchronous motors in a weatherproof housing.  The FrightProps and
// MonsterGuts deer motors are identical.  There are other sources of
// deer motors, but watch out for differences.  The dropper works only
// with motors that turn CLOCKWISE.  Motors that reverse direction
// when they encounter resistance are incompatible.
//
// The deer motor can be mounted using the screws that are already
// part of the motor housing.  However, I recommend replacing the four
// mounting screws with M3x14mm roundhead (or flanged head)
// self-tapping screws.
//
// The deer motor will require that 7mm shaft adapter, two M3x6mm
// machine screws, and two M3 square nuts.

// The DC version was designed for an Aslong JGY-370 12VDC worm
// gear motor, but nearly any lookalike model will work as long as
// the mounting hole pattern aligns with the base plate.  A 6 RPM
// version is recommended, but slower ones can be used.  Ones faster
// than 10 RPM may not allow enough time for the drop, which can
// lead to a jam.
//
// The JGY motor will requires the 6mm shaft adapter, six M3x6mm
// machine screws, and two M3 square nuts.
//
// The DC version requires soldering wires to the motor terminals.
// Make sure you have it wired so that it turns CLOCKWISE when
// power is applied.
//
// The DC version can be upgraded with the "slightly smarter" option,
// which consists of a circuit board, and a mini PIR motion sensor.
// It requires one more M3x6mm machine screw and square nut.
//
// Other than the shaft adapters, the 3D-printed parts are identical
// for all versions.

Include_Base_Plate = true;
Include_6mm_Shaft_Adapter = true;
Include_7mm_Shaft_Adapter = false;
Include_Spool_Assembly = true;
Include_Drive_Gear = true;
Include_PCB_Model = false;

module __Customizer_Limit__ () {}

use <aidgear.scad>
use <honeycomb.scad>

function inch(x) = x * 25.4;
function thou(x) = inch(x/1000);

function round_up(n, base=1) =
    n % base == 0 ? n : floor((n+base)/base)*base;

function lerp(t, x0=0, x1=1) = x0 + t*(x1 - x0);
function mid(x0, x1) = lerp(0.5, x0, x1);

function nut_diameter(nut_w, nut_sides=6, nozzle_d=0.4) =
    nozzle_d +
    ((nut_sides % 2) == 0 ?
        round_up(nut_w / cos(180/nut_sides), nozzle_d) :
        nut_w);

// Dimensions of the hardware we're going to incorporate.

// Nearly all screws used are M3.
m3_free_d = 3.4;
m3_head_d = 6.0;
m3_head_h = 2.4;
m3_flange_d = 7.0;
m3_nut_w = 5.5;
m3_nut_h = 2.4;
m3_sqnut_w = 5.5;
m3_sqnut_h = 2.3;

// The deer motor uses an M4 screw for the hub.
m4_free_d = 4.5;
m4_head_d = 8.0;
m4_head_h = 3.1;

// Widely available "skateboard" bearings.
bearing608_od = 22;
bearing608_id = 8;
bearing608_th = 7;

// Diameter of the string used to suspend the spider.
string_d = 0.5;

// Key dimensions for "reindeer" motors like those sold by FrightProps
// and MonsterGuts.  These are 5-6 RPM synchronous AC motors in a weather
// resistant housing.
deer_shaft_d = 7.0;
deer_shaft_h = 6.2;
// The base is a circular area around the shaft that rises above the
// mounting face of the motor.
deer_base_d = 20;  // at the face plate.  Tapers down to 17.
deer_base_h = 5;
deer_mount_screw = "M3 self-tapping";  // a #6 would fit
deer_mount_screw_l = 16;
deer_mount_screw_depth = 15;
deer_mount_screw_takeup = deer_mount_screw_l - deer_mount_screw_depth;
deer_mount_screw_head_d = max(m3_head_d, m3_flange_d);
deer_mount_screw_head_h = m3_head_h;
deer_mount_screw_free_d = m3_free_d;
deer_mount_dx1 = 81;  // separation between mounting screws nearest the hub
deer_mount_dx2 = 57;
deer_mount_dy1 = 17; // hub to dx1 line
deer_mount_dy2 = 35 + deer_mount_dy1; // hub to dx2 line
deer_w = 90;
deer_l = 90;
deer_h = 37.6;

// Key dimensions for the Aslong JGY-370 DC gearmotors (and look alikes).
jgy_shaft_d = 6.0;
jgy_shaft_h = 14;
jgy_base_d = 13.2;
jgy_base_h = 0;
jgy_mount_screw = "M3";
jgy_mount_screw_l = 6;
jgy_mount_screw_depth = 4;
jgy_mount_screw_takeup = jgy_mount_screw_l - jgy_mount_screw_depth;
jgy_mount_screw_head_d = m3_head_d;
jgy_mount_screw_head_h = m3_head_h;
jgy_mount_screw_free_d = m3_free_d;
jgy_mount_dx1 = 18;
jgy_mount_dx2 = 18;
jgy_mount_dy1 = -9;
jgy_mount_dy2 = 33 + jgy_mount_dy1;
jgy_w = 32;
jgy_l = 81;
jgy_h = 27;

// Mounting points for both motors.
// [0] = [x, y] position, relative to center of shaft
// [1] = head diameter
// [2] = head height
// [3] = free diameter
// [4] = minimum "takeup" (amount of screw length the plate must consume)
mounting_holes = [
    [[-jgy_mount_dx1/2, -jgy_mount_dy1],   jgy_mount_screw_head_d,  jgy_mount_screw_head_h, jgy_mount_screw_free_d, jgy_mount_screw_takeup],
    [[ jgy_mount_dx1/2, -jgy_mount_dy1],   jgy_mount_screw_head_d,  jgy_mount_screw_head_h, jgy_mount_screw_free_d, jgy_mount_screw_takeup],
    [[-jgy_mount_dx2/2, -jgy_mount_dy2],   jgy_mount_screw_head_d,  jgy_mount_screw_head_h, jgy_mount_screw_free_d, jgy_mount_screw_takeup],
    [[ jgy_mount_dx2/2, -jgy_mount_dy2],   jgy_mount_screw_head_d,  jgy_mount_screw_head_h, jgy_mount_screw_free_d, jgy_mount_screw_takeup],
    [[-deer_mount_dx1/2, -deer_mount_dy1], deer_mount_screw_head_d, deer_mount_screw_head_h, deer_mount_screw_free_d, deer_mount_screw_takeup],
    [[ deer_mount_dx1/2, -deer_mount_dy1], deer_mount_screw_head_d, deer_mount_screw_head_h, deer_mount_screw_free_d, deer_mount_screw_takeup],
    [[-deer_mount_dx2/2, -deer_mount_dy2], deer_mount_screw_head_d, deer_mount_screw_head_h, deer_mount_screw_free_d, deer_mount_screw_takeup],
    [[ deer_mount_dx2/2, -deer_mount_dy2], deer_mount_screw_head_d, deer_mount_screw_head_h, deer_mount_screw_free_d, deer_mount_screw_takeup]
];

pcb_w = 20;
pcb_l = 80;
pcb_th = 1.6;  // +/- 0.16
pcb_cut = 3;  // diagonal cuts on two corners for orientation
pcb_clearance = 1.2;  // PCB design has clearance around the edges
pcb_to_index = [-pcb_l/2 + 20, -pcb_w/2]; // center to center
pcb_index_r = 3;  // size of the index notch
pcb_to_mount_screw = [pcb_l/2 - 20, -pcb_w/2 + 5];  // center to center
pcb_mount_screw_d = 3.2;  // M3 close fit, but standards vary
pcb_to_switch_op = [0, pcb_w/2 - 5];  // PCB center to switch operating point
switch_op_to_switch = [5.08, 0];

// The microswitch on the "Slightly Smarter" PCB.
switch_h = 6.5;  // body height above the PCB
// The operating point is 8.4+/-0.8mm above the PCB, and there's at
// least 0.6mm of overtravel.
switch_up_h   = 8.4 + 0.8;  // switch is definitely up
switch_down_h = 8.4 - 0.8;  // switch is definitely down
switch_hard_stop_h = switch_down_h - 0.6;  // lowest point ever allowed
switch_w = 5.8;
switch_l = 12.8;

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

module track(r, track_w=1) {
    difference() {
        offset(track_w/2) circle(r=r);
        offset(-track_w/2) circle(r=r);
    }
}

module clean_cylinder(h=1, r=undef, d=undef, d1=undef, d2=undef, chamfer=0, horizontal=false, clear=0, center=false) {
    diameter = !is_undef(r) ? 2*r : !is_undef(d) ? d : 1;
    diameter1 = !is_undef(d1) ? d1 : diameter;
    diameter2 = !is_undef(d2) ? d2 : diameter;
    r1 = diameter1/2;
    r2 = diameter2/2;
    assert(r1 > 0 && r2 > 0);
    z1 = center ? -h/2 : 0;
    z2 = z1 + h;
    points = [
        [0, z1-clear],
        [0, z2+clear],
        [r2+chamfer, z2+clear],
        [r2+chamfer, z2],
        [r2, z2-abs(chamfer)],
        [r1, z1+abs(chamfer)],
        [r1+chamfer, z1],
        [r1+chamfer, z1-clear]
    ];
    r = horizontal ? [0, -90, 0] : [0, 0, 0];
    rotate(r) rotate_extrude(convexity=4) polygon(points);
}

// Makes a star-shaped polygon of count points.
module spline_shape(count, od, id) {
    assert(count >= 3);
    assert(0 < id && id < od);
    or = od/2;
    ir = id/2;
    dtheta = 360 / count;
    htheta = 1/2 * dtheta;
    polygon([
        for (theta=[0:dtheta:360-dtheta])
        each [
            [or*cos(theta), or*sin(theta)],
            [ir*cos(theta+htheta), ir*sin(theta+htheta)]
        ]
    ]);
}

module spider_dropper(drop_distance=inch(24), nozzle_d=0.4) {
    $fs = nozzle_d/2;

    min_th = 3*nozzle_d;
    wall_th = 2*min_th;

    // To simplify kits, we strive to use the same screw size as
    // much as possible.
    m3_screw_l = jgy_mount_screw_l;
    assert(m3_screw_l >= jgy_mount_screw_depth + min_th);

    // VERTICAL STACK

    // The plate must be thick enough that the heads of the motor
    // mounting screw are flush or recessed.
    plate_th = max(
        deer_mount_screw_head_h + max(min_th, deer_mount_screw_takeup),
        jgy_mount_screw_head_h  + max(min_th, jgy_mount_screw_takeup)
    );
    echo(str("plate_th = ", plate_th));

    // The highest point reached by either of the motor shafts.
    shaft_max_z = max(
        deer_base_h + deer_shaft_h,
        jgy_base_h  + jgy_shaft_h
    );

    // The horizontal set screws in the shaft adapters must clear the top
    // of the plate so that they're accessible.  
    set_screw_z = plate_th + min_th + m3_head_d/2;
    assert(set_screw_z + m3_head_d/2 <= shaft_max_z);
    echo(str("set_screw_z = ", set_screw_z));

    // The target thickness of the meshing portion of gears.
    gear_th = bearing608_th;

    // The spool assembly contains two 608 bearings.
    spool_assembly_th = 2*bearing608_th;

    // The winder gear (of the spool assembly) needs to be elevated a
    // small amount relative to the top face of the spool.  The easiest
    // way to do this, without needing supports, is to make the winder
    // a little thicker.
    winder_th = gear_th + min_th;
    echo(str("winder_th = ", winder_th));

    // So the spool thickness is whatever is left over.
    spool_th = spool_assembly_th - winder_th;
    assert(spool_th >= min_th + 3*string_d + min_th);
    echo(str("spool_th = ", spool_th));

    // The top of the winder gear (which is the top of the spool
    // assembly), should be at least as high as the high point of the
    // motor shaft.  It also needs to be high enough that the drive
    // gear is above the set screws.
    spool_assembly_z1 = max(
        shaft_max_z,
        plate_th + min_th + spool_assembly_th,
        set_screw_z + m3_head_d/2 + min_th + gear_th
    );
    winder_z1 = spool_assembly_z1;
    winder_z0 = winder_z1 - winder_th;
    spool_z1 = winder_z0;
    spool_z0 = spool_z1 - spool_th;
    spool_assembly_z0 = spool_z0;

    // The hole in the guide must align with the center of the spool.
    guide_z = spool_z0 + 0.5*spool_th;

    // The spacer is part of the plate that holds the spool assembly
    // clear of the face of the plate
    spacer_h = spool_assembly_z0 - plate_th;
    assert(spacer_h >= min_th);
    echo(str("spacer_h = ", spacer_h));

    drive_th = gear_th;
    drive_z1 = spool_assembly_z1;
    drive_z0 = drive_z1 - drive_th;
    assert(drive_z0 > spool_z1);
    echo(str("drive_z0 = ", drive_z0));
    echo(str("shaft_max_z = ", shaft_max_z));

    // The switch must be high enough that the bottom face of the
    // drive gear will activate it.
    switch_z = min(drive_z0 - switch_down_h - 0.1);
    assert(switch_z <= plate_th + min_th);
    index_depth = switch_up_h - switch_down_h + 0.2;
    assert(index_depth < drive_th / 2);
    pcb_z = switch_z - pcb_th;
    assert(pcb_z >= min_th);
    echo(str("pcb_z = ", pcb_z));
    pcb_support_h = max(pcb_z + pcb_th + nozzle_d, plate_th);
    
    // HORIZONTAL LAYOUT
    motor_w = max(deer_w, jgy_w);
    motor_h = max(deer_h, jgy_h);
    motor_base_d = max(deer_base_d, jgy_base_d);
    motor_base_h = max(deer_base_h, jgy_base_h);

    adapter_d = motor_base_d - 3;
    echo(str("adapter_d = ", adapter_d));
    adapter_sides = 8;
    assert(adapter_sides % 2 == 0);
    adapter_r = adapter_d/2 * cos(180/adapter_sides);

    // This is the model for the drive gear, which is connected directly
    // to the motor shaft.
    model_gear = AG_define_gear(
        iso_module=1.5,
        tooth_count=57,
        thickness=drive_th,
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
    drive_teeth = AG_tooth_count(model_gear);
    actual_drive_teeth = ceil(4/5 * drive_teeth);
    drive_gear =
        AG_depopulated_gear(
            model_gear,
            [actual_drive_teeth+1:drive_teeth]
        );
    AG_echo(drive_gear);

    // The drive gear turns the winder gear, which is attached to the
    // spool.
    winder_gear = AG_define_gear(
        tooth_count=19,
        thickness=winder_th,
        mate=drive_gear
    );
    assert(AG_root_diameter(winder_gear) > bearing608_od + min_th);
    AG_echo(winder_gear);

    shaft_to_axle = [AG_center_distance(drive_gear, winder_gear), 0];
    echo(str("shaft_to_axle = ", shaft_to_axle));

    // The spline is the shape used to key the shaft adapter to the
    // drive gear.
    spline_od = adapter_d;
    spline_id = max(
        jgy_shaft_d + 2*min_th,
        deer_shaft_d + 2*min_th,
        spline_od/2
    );
    spline_count = adapter_sides;

    spool_turns = actual_drive_teeth / AG_tooth_count(winder_gear);
    spool_d = drop_distance / (spool_turns * PI);  // to bottom of groove
    assert(spool_d > bearing608_od + min_th);
    spool_flange_d = spool_d + 4*string_d*ceil(spool_turns);
    echo(str("spool_turns = ", spool_turns,
             "; spool_d = ", spool_d,
             "; spool_flange_d = ", spool_flange_d));

    // TODO: The axle needs to snug up tighter against the inner race
    // of the bearings.  The bounce at the bottom of the drop is much
    // less severe when the inner race isn't as free to spin around
    // the axle.
    axle_l = 2*bearing608_th + nozzle_d;
    axle_d = bearing608_id;

    // The bottom bearing rests against the spacer, which should contact
    // only the inner ring.
    spacer_d = bearing608_id + 3;

    plate_l =
        wall_th +
        AG_tips_diameter(drive_gear)/2 +
        shaft_to_axle.x +
        spool_flange_d/2 +
        min_th +
        wall_th;
    plate_w =
        wall_th +
        max(AG_tips_diameter(drive_gear),
            spool_flange_d + min_th,
            motor_w) +
        wall_th;
    plate_r = 10;  // radius for rounded corners
    echo(str("plate_w = ", plate_w, "; plate_l = ", plate_l));

    // Translate plate to center motor shaft at the origin.
    plate_offset =
        [plate_l/2 - (plate_th + AG_tips_diameter(drive_gear))/2, 0];

    honeycomb_size = 14;
    
    // The "slightly smarter" version uses a small PCB that attaches to
    // the base plate.  One side has a switch whose lever rides in a
    // channel of the drive gear so that it is depressed once per
    // revolution.
    shaft_to_switch_op = [-35, 0];
    track_w = 8;

    assert(AG_root_diameter(drive_gear) > abs(shaft_to_switch_op.x) + track_w/2 + min_th);

    module spline_hub() {
        offset(nozzle_d/2) offset(-nozzle_d/2)
            spline_shape(spline_count, spline_od, spline_id);
    }

    module spline_hole() {
        offset(-nozzle_d/2) offset(5/8*nozzle_d)
            spline_shape(adapter_sides, spline_od, spline_id);
    }

    module drive_gear() {
        arrow_r = 0.35*AG_tips_diameter(drive_gear);
        track_r = abs(shaft_to_switch_op.x);
        last_tooth = actual_drive_teeth - 1;
        advance = 2;  // stop 2 drive teeth before the drop
        degrees_to_switch = 180;
        index_angle =
            360*(last_tooth - advance)/drive_teeth + degrees_to_switch;
        rpm = 6;
        seconds_to_hold = 1;
        sweep = 360 * rpm / 60 * seconds_to_hold;
        sector_r = AG_root_diameter(drive_gear)/2 - min_th;

        translate([0, 0, AG_thickness(drive_gear)]) rotate([180, 0, 0])
        difference() {
            union() {
                difference() {
                    AG_gear(drive_gear);
                    translate([0, 0, AG_thickness(drive_gear)])
                        linear_extrude(2*nozzle_d, center=true)
                            circular_arrow(arrow_r, 160, 20);
                }
            }
            translate([0, 0, -0.01]) {
                linear_extrude(2+nozzle_d+0.01, convexity=4) {
                    difference() {
                        track(r=track_r, track_w=track_w, $fa=2);
                        rotate([0, 0, index_angle]) {
                            sector(r=sector_r, sweep=sweep, $fa=2);
                        }
                    }
                }
                linear_extrude(AG_thickness(drive_gear) + 0.02) {
                    spline_hole();
                }
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
                        linear_extrude(spool_th, convexity=4)
                            rotate([0, 0, 45])
                                square(string_d, center=true);
                }
                
                translate([spool_d/2-plate_th, 0, spool_th/2]) {
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
                    y1 = spool_th;
                    y2 = y1 - (r1-r2);
                    y3 = min(y0 + (r1-r2), y2);
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
                translate([0, 0, spool_th])
                    linear_extrude(2, convexity=6, center=true)
                        circular_arrow(0.35*spool_flange_d, 100, 260);
            }
        }

        difference() {
            union() {
                spool();
                translate([0, 0, spool_th]) AG_gear(winder_gear);
            }
            clean_cylinder(h=spool_assembly_th, d=bearing608_od,
                           chamfer=nozzle_d, clear=1);
        }
    }
    
    module axle() {
        // This generates the spacer, which rises through the base plate,
        // the axle itself, the chamfer at the top, a hollow space inside
        // that makes the axle stronger because it generates more
        // perimeters, and a conical indentation at the top end (which
        // could provide alignment and support from an upper plate).
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

    // The guide ensures the string wraps onto the spool.
    module guide() {
        th = wall_th;
        id = 4*string_d;
        od = max(3*id, id + 2*min_th);
        base_w = 2*od;
        base_h = plate_th;

        rotate([90, 0, 0]) {
            difference() {
                linear_extrude(th, center=true) {
                    difference() {
                        hull() {
                            circle(d=od);
                            translate([-base_w/2, -guide_z])
                                square([base_w, base_h]);
                        }
                    }
                }
                rotate_extrude(convexity=4, $fs=nozzle_d/2) {
                    hole_th = th + nozzle_d;
                    hole_d = id + nozzle_d;
                    difference() {
                        translate([0, -hole_th/2])
                            square([hole_d, hole_th]);
                        translate([hole_d/2 + hole_th, 0])
                            circle(d=2*hole_th, $fn=48);
                    }
                }
            }
        }
    }

    module pcb_footprint() {
        // The KiCad PCB design uses a left-handed coordinate system,
        // considers the origin to be the corner closes to the power
        // connector, and treats the component side as the front.
        // Note that the switch is on the opposite side from the other
        // components.
        // This SCAD footprint uses a right-handed coordinate system,
        // considers the origin to be the center of the board, and
        // has the component side facing +Z.
        // When mounted to the base plate, the component side of the
        // board faces "down" (toward the motor side).
        cut = pcb_cut;
        l = -pcb_l/2;
        r =  pcb_l/2;
        t =  pcb_w/2;
        b = -pcb_w/2;
        difference() {
            polygon([
                [l, b],
                [l, t],
                [r-cut, t],
                [r, t-cut],
                [r, b+cut],
                [r-cut, b]
            ]);
            translate(pcb_to_index) circle(r=pcb_index_r+nozzle_d/2);
            translate(pcb_to_mount_screw) circle(d=pcb_mount_screw_d+nozzle_d);
        }
    }
    
    module pcb_model() {
        module switch_model() {
            translate(-switch_op_to_switch) {
                linear_extrude(switch_h) {
                    square([switch_l, switch_w], center=true);
                }
                rotate([90, 0, 0]) linear_extrude(3, center=true) {
                    polygon([
                        [-switch_l/2+min_th, 0],
                        [-switch_l/2+min_th, switch_h],
                        [switch_l/2 + 1.6, switch_hard_stop_h],
                        [switch_l/2, 0]
                    ]);
                }
            }
        }
        
        translate([0, 0, pcb_th]) rotate([0, 180, 0]) {
            color("green")
            difference() {
                linear_extrude(pcb_th, convexity=8) pcb_footprint();
                // etch the outline of the edge clearance
                translate([0, 0, pcb_th - nozzle_d]) {
                    linear_extrude(pcb_th, convexity=4) difference() {
                        offset(r=-pcb_clearance+nozzle_d) pcb_footprint();
                        offset(r=-pcb_clearance) pcb_footprint();
                    }
                }
            }
            // The switch is on the opposite side
            rotate([0, 180, 0]) color("white") {
                translate(pcb_to_switch_op) switch_model();
            }
        }
    }

    module pcb_mounting_tab() {
        nut_d = sqrt(2*(m3_sqnut_w*m3_sqnut_w));
        tab_w = max(m3_head_d, nut_d) + 2*min_th;

        hull() {
            circle(d=tab_w);
            translate([-tab_w/2, -5]) square([tab_w, 5]);
        }
    }

    module base_plate() {
        module footprint() {
            offset(plate_r) offset(-plate_r)
                square([plate_l, plate_w], center=true);
        }

        difference() {
            union() {
                linear_extrude(plate_th, convexity=8) union() {
                    cutaway(outline=min_th) {
                        union() {
                            translate(plate_offset) {
                                bounded_honeycomb(plate_l, plate_w, honeycomb_size,
                                                  min_th, center=true) {
                                    footprint();
                                }
                                outline(-wall_th) footprint();
                            }

                            // add bosses for the motor mounting screws
                            for (hole=mounting_holes) {
                                rotate([0, 0, 90]) translate(hole[0]) {
                                    offset(min_th+nozzle_d) circle(d=hole[1]);
                                }
                            }
                        }

                        // cutaways
                        circle(d=motor_base_d+nozzle_d);
                        for (hole=mounting_holes) {
                            rotate([0, 0, 90]) translate(hole[0]) {
                                circle(d=hole[3]+nozzle_d);
                            }
                        }
                    }
                }

                // PCB support
                linear_extrude(pcb_support_h, convexity=8) {
                    translate(shaft_to_switch_op) {
                        rotate([180, 0, 0]) rotate([0, 0, 90]) {
                            translate(-pcb_to_switch_op) {
                                offset(min_th+nozzle_d) pcb_footprint();
                            }
                        }
                    }
                }
            }

            // Recess the heads of the motor mounting screws.
            rotate([0, 0, 90]) {
                for (hole=mounting_holes) {
                    translate([0, 0, min(plate_th-hole[2], hole[4])]) {
                        linear_extrude(plate_th) {
                            translate(hole[0]) circle(d=hole[1] + nozzle_d);
                        }
                    }
                }
            }

            // Recess the PCB to hold it at the proper height.
            translate(shaft_to_switch_op) {
                translate([0, 0, pcb_z]) {
                    linear_extrude(pcb_support_h+0.02, convexity=8) {
                        rotate([180, 0, 0]) rotate([0, 0, 90]) {
                            translate(-pcb_to_switch_op) {
                                offset(delta=nozzle_d) pcb_footprint();
                            }
                        }
                    }
                }
            }

            // Punch out for the components on the PCB.
            translate(shaft_to_switch_op) translate([0, 0, -0.01]) {
                linear_extrude(pcb_support_h+0.02, convexity=8) {
                    rotate([180, 0, 0]) rotate([0, 0, 90]) {
                        translate(-pcb_to_switch_op) {
                            difference() {
                                offset(-pcb_clearance) pcb_footprint();
                                translate(pcb_to_mount_screw) {
                                    pcb_mounting_tab();
                                }
                            }
                            translate(pcb_to_mount_screw) {
                                circle(d=pcb_mount_screw_d+nozzle_d);
                            }
                        }
                    }
                }

                // Finally, a nut pocket for the PCB mounting screw.  This
                // requires incremental bridging for the floating hole.
                if (pcb_z >= m3_sqnut_h + min_th) {
                    translate([0, 0, pcb_z - min_th - plate_th - 0.01]) {
                        linear_extrude(plate_th+0.01-nozzle_d) {
                            rotate([180, 0, 0]) rotate([0, 0, 90]) {
                                translate(pcb_to_mount_screw-pcb_to_switch_op) {
                                    offset(nozzle_d/2) {
                                        square(m3_sqnut_w, center=true);
                                    }
                                }
                            }
                        }
                        linear_extrude(plate_th+0.01) {
                            rotate([180, 0, 0]) rotate([0, 0, 90]) {
                                translate(pcb_to_mount_screw-pcb_to_switch_op) {
                                    offset(nozzle_d/2) {
                                        square([m3_sqnut_w, pcb_mount_screw_d],
                                               center=true);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        translate(shaft_to_axle) axle();
        translate([shaft_to_axle.x, -(plate_w - wall_th)/2, guide_z])
            guide();

        // Alternate guide if the user wants the mechanism in the taller
        // orientation.
        translate([plate_offset.x + (plate_l-wall_th)/2, 0, guide_z]) {
            rotate([0, 0, 90]) guide();
        }
    }

    module shaft_adapter(
        motor_shaft_d=deer_shaft_d,
        motor_base_h=deer_base_h,
        nozzle_d=0.4
    ) {
        base_h = drive_z0 - motor_base_h;
        nut_dx = (motor_shaft_d + m3_sqnut_h)/2 + 2*nozzle_d;

        spline_h = max(drive_z1 - drive_z0 + nozzle_d, gear_th);
        z=set_screw_z - motor_base_h;

        module nut_pocket() {
            pocket_h = z + (m3_sqnut_w + nozzle_d)/2 + 0.01;
            translate([0, 0, -0.01]) {
                linear_extrude(pocket_h, convexity=4)
                    offset(nozzle_d/2)
                        square([m3_sqnut_h, m3_sqnut_w], center=true);
            }
        }

        difference() {
            rotate([0, 0, 180/adapter_sides]) {
                    clean_cylinder(h=base_h, d=adapter_d, $fn=adapter_sides);
                translate([0, 0, base_h-0.01]) {
                    linear_extrude(spline_h + 0.01 - min_th, convexity=6) {
                        spline_hub();
                    }
                    translate([0, 0, spline_h - min_th]) {
                        linear_extrude(min_th+0.01, scale=0.98, convexity=6) {
                            spline_hub();
                        }
                    }
                }
            }
            clean_cylinder(h=base_h+spline_h, d=motor_shaft_d + nozzle_d/2,
                           chamfer=nozzle_d, clear=0.01, $fs=nozzle_d/2);
            translate([0, 0, set_screw_z - motor_base_h]) {
                clean_cylinder(h=2*adapter_r, d=m3_free_d, chamfer=nozzle_d,
                               horizontal=true, clear=1, center=true,
                               $fs=nozzle_d/2);
            }
            translate([ nut_dx, 0, 0]) nut_pocket();
            translate([-nut_dx, 0, 0]) nut_pocket();

            // Little slots allow insertion of a prying tool in case the
            // fit between the gear and the spline is too tight.
            translate([0, 0, base_h-min_th]) {
                linear_extrude(min_th + 0.01, convexity=4) {
                    rotate([0, 0, 90])
                        translate([adapter_r-1.7, -3/2]) square(3);
                    rotate([0, 0, -90])
                        translate([adapter_r-1.7, -3/2]) square(3);
                }
            }
        }
    }

//    !union() {
////        translate([0, 25, 0]) shaft_adapter(deer_shaft_d, deer_base_h);
//        shaft_adapter(jgy_shaft_d, jgy_base_h);
//        color("orange") translate([-25, 0, 0]) {
//            linear_extrude(gear_th, convexity=8) {
//                rotate([0, 0, 180/adapter_sides])
//                difference() {
//                    circle(d=30, $fn=8);
//                    spline_hole();
//                }
//            }
//        }
//    }

    echo(str("\n",
        "design teeth:\t", AG_tooth_count(model_gear), "\n",
        "actual teeth:\t", actual_drive_teeth, "\n",
        "drive diameter:\t", AG_tips_diameter(drive_gear), " mm\n",
        "spool diameter:\t", spool_flange_d, " mm\n",
        "plate size:\t", plate_l, " mm x ", plate_w, " mm x ", plate_th, " mm\n"));

    show_assembled = $preview;

    if (Include_Base_Plate) {
        color("springgreen") base_plate();
    }

    if (Include_PCB_Model) {
        color("green")
        if (show_assembled) {
            translate(shaft_to_switch_op) {
                translate([0, 0, pcb_z]) rotate([0, 0, 90]) {
                    translate(-pcb_to_switch_op) pcb_model();
                }
            }
        } else {
            translate([-((plate_l + pcb_w)/2 + 1), 0, 0] + plate_offset) {
                rotate([0, 0, 90]) pcb_model();
            }
        }
    }

    if (Include_6mm_Shaft_Adapter) {
        color("dodgerblue")
        if (show_assembled) {
            translate([0, 0, jgy_base_h]) rotate([0, 0, 180/adapter_sides]) {
                shaft_adapter(jgy_shaft_d, jgy_base_h);
            }
        } else {
            shaft_adapter(jgy_shaft_d, jgy_base_h);
        }
    }
    
    if (Include_7mm_Shaft_Adapter) {
        color("purple")
        if (show_assembled && !Include_6mm_Shaft_Adapter) {
            translate([0, 0, deer_base_h]) rotate([0, 0, 180/adapter_sides]) {
                shaft_adapter(deer_shaft_d, deer_base_h);
            }
        } else {
            translate([0, -((plate_w + adapter_d)/2 + 1), 0]) {
                shaft_adapter(deer_shaft_d, deer_base_h);
            }
        }
    }

    if (Include_Spool_Assembly) {
        echo(str("shaft_to_axle = ", shaft_to_axle));
        echo(str("spool_assembly_z0 = ", spool_assembly_z0));
        color("orange")
        if (show_assembled) {
            translate(shaft_to_axle) translate([0, 0, spool_assembly_z0]) {
                spool_assembly();
            }
        }
    }

    if (Include_Drive_Gear) {
        color("yellow")
        if (show_assembled) {
            translate([0, 0, drive_z1]) rotate([180, 0, 0]) drive_gear();
        } else {
            translate([0, (plate_w + AG_tips_diameter(drive_gear))/2 + 1, 0])
                drive_gear();
        }
    }

//    if (!$preview) {
//        echo(str(
//            "\nPRINTING INSTRUCTIONS\n",
//            "\nExport the model and slice it with a 0.2 mm or 0.3 mm layer\n",
//            "height. It has been tested with PETG, but PLA is probably fine.\n"
//        ));
//    }
}

drop_distance = inch(Drop_Distance);

spider_dropper(drop_distance=drop_distance);

