// Experimenting with designs for an adapter system that allows
// different motor shafts to interface with the same gears, wheels,
// pulleys, etc.

use <aidgear.scad>

module shaft_cross_section(d, flat1=0, flat2=0, nozzle_d=0.4) {
    intersection() {
        circle(d=d, $fs=nozzle_d/2);
        translate([-flat1, 0, 0]) square(d, center=true);
        translate([ flat2, 0, 0]) square(d, center=true);
    }
}

// Uses its child(ren) to create a shaped vertical hole and the
// arguments to add an envelope to accomodate a hub screw.  Uses
// `layer_h` to create a "sacrificial bridge" so a part with this
// hole can be printed without slicer-generated supports.
module shaft_bore(shaft_h, screw_d, screw_l, head_d, head_h, nozzle_d=0.4, layer_h=0.2) {
    translate([0, 0, -shaft_h])
        linear_extrude(shaft_h) offset(r=nozzle_d/2) children();
    linear_extrude(screw_l-layer_h)
        offset(nozzle_d/2) circle(d=screw_d, $fs=nozzle_d/2);
    translate([0, 0, screw_l]) {
        linear_extrude(head_h)
            offset(nozzle_d/2) circle(d=head_d, $fs=nozzle_d/2);
    }
}

min_th = 1.2;

function spline_profile() =
    // We're using a spur gear as a convenient shape for the profile,
    // but it's not actually being used as a gear.
    let (
        base_shape = AG_define_gear(iso_module=1, tooth_count=20, thickness=6),
        shape = AG_depopulated_gear(base_shape, 1)
    )
    echo(AG_tips_diameter(shape))
    AG_tooth_profile(shape);

function scale_at_h(h) = 1 + h*0.1/7;

module adapter(h=7, bore_d=0, nozzle_d=0.4) {
    $fs=nozzle_d/2;
    difference() {
        linear_extrude(h, scale=scale_at_h(h), convexity=10)
            difference() {
                polygon(spline_profile());
                offset(nozzle_d/2) circle(d=bore_d);
            }
        translate([0, 0, 1.2])
            linear_extrude(h)
                offset(nozzle_d/4) children();
        // pocket for square M3 nut
        translate([6, 0, 7/2]) {
            translate([-(2.2+nozzle_d)/2, -(5.3+nozzle_d)/2, -(5.3+nozzle_d)/2])
                cube([2.2+nozzle_d, 5.3+nozzle_d, h+nozzle_d]);
            rotate([0, 90, 0]) {
                cylinder(h=22/2, d=3.4, center=true);
                translate([0, 0, 3]) cylinder(h=2.4, d=6);
            }
        }

    }
}

module spline_hollow(h=5, bore_d=0, nozzle_d=0.4) {
    $fs=nozzle_d/2;
    linear_extrude(h+1) offset(nozzle_d/2) circle(d=bore_d);
    translate([0, 0, 5])
        rotate([180, 0, 0])
            linear_extrude(6, scale=scale_at_h(6), convexity=10)
                offset(nozzle_d/4) polygon(spline_profile());
}

gear = AG_define_gear(iso_module=2, tooth_count=18, thickness=7);
module hollowed_gear() {
    difference() {
        AG_gear(gear);
        spline_hollow(h=AG_thickness(gear), bore_d=4);
    }
}


translate([70, 0, 0])
    adapter(bore_d=3) shaft_cross_section(6, 0.5);
translate([40, 0, 0])
    adapter(bore_d=4) shaft_cross_section(7, 0.75, 0.75);
translate([0, 0, AG_thickness(gear)]) rotate([180, 0, 0]) hollowed_gear();



// JGY 370 worm gear DC motor
//shaft_bore(10, 3, min_th, 6, 2.4) shaft_cross_section(6, 0.5);


