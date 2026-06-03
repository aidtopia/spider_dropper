// Representation of "reindeer" motor for visualization.
// Adrian McCarthy 2026-05-30.
//
// Reindeer motors are synchronous AC motors in a (usually white)
// weather-resistant housing.  They are commonly used to slowly
// animate lighted wireframe reindeer Christmas decorations.  They
// are available as "small prop motors" from FrightProps and
// Monster Guts.

module deer_motor(angle=0, nozzle_d=0.4) {
    m3_free_d = 3.4;
    m3_close_d = 3.2;
    m3_head_d = 6.0;
    m3_head_h = 2.4;
    m3_flange_d = 7.0;

    deer_shaft_d = 7.0;
    deer_shaft_h = 6.2;
    // The base is a circular area around the shaft that rises above the
    // mounting face of the motor.
    deer_base_d = 20;  // at the face plate.  Tapers down to 17.
    deer_base_h = 5;
    deer_mount_dx1 = 81;  // separation between mounting screws nearest the hub
    deer_mount_dx2 = 57;
    deer_mount_dy1 = 17; // hub to dx1 line
    deer_mount_dy2 = 35 + deer_mount_dy1; // hub to dx2 line
    deer_w = 90;
    deer_l = 90;
    deer_h = 37.6;

    module footprint() {
        hull() {
            scale([22, 18]) circle(r=1, $fn=32);
            translate([0, -8]) scale([36, 18]) circle(r=1, $fn=48);
            translate([0, -27]) scale([35, 18]) circle(r=1, $fn=48);
            offset(r=3, $fs=nozzle_d/2) offset(delta=-3) {
                translate([-11, -72]) square(22);
            }
        }
    }
    
    module mount_boss() {
        translate([0, 0, -11]) {
            linear_extrude(11, convexity=4) {
                difference() {
                    circle(d=7.8, $fs=nozzle_d/2);
                    circle(d=3, $fs=nozzle_d/2);
                }
            }
            translate([0, 0, -9]) linear_extrude(15,2, scale=1.125) {
                circle(d=5, $fs=nozzle_d/2);
            }
            translate([0, 0, -7]) linear_extrude(7) {
                translate([0, -1]) square([7, 2]);
            }
        }
        translate([0, 0, -5-6.2]) {
            linear_extrude(6.2) hull() {
                circle(d=8, $fs=nozzle_d/2);
                translate([7, 0]) square([1, 15], center=true);
            }
        }
    }
    
    module clamp_boss() {
        translate([0, 0, -11]) {
            translate([0, 0, -9]) linear_extrude(15.2, scale=1.125) {
                circle(d=5, $fs=nozzle_d/2);
            }
            translate([0, 0, -7]) linear_extrude(7) {
                translate([0, -1]) square([7, 2]);
            }
        }

        translate([0, 0, -5-6.2]) {
            linear_extrude(6.2) union() {
                circle(d=8, $fs=nozzle_d/2);
                translate([3.5, 0]) square(7, center=true);
            }
        }
    }

    translate([0, 0, -deer_h]) {
        difference() {
            linear_extrude(deer_h) {
                offset(r=2.5, $fs=nozzle_d/2) offset(delta=-5) {
                    footprint();
                }
            }
            translate([-deer_w/2, -deer_l+20, -1]) {
                linear_extrude(13.5+1) {
                    square([deer_w, 40]);
                }
            }
        }
    }
    translate([0, 0, -5-6.2]) linear_extrude(6.2) footprint();
    
    translate([-deer_mount_dx1/2, -deer_mount_dy1]) mount_boss();
    translate([ deer_mount_dx1/2, -deer_mount_dy1]) rotate([0, 0, 180]) mount_boss();
    translate([-deer_mount_dx2/2, -deer_mount_dy2]) rotate([0, 0,  30]) mount_boss();
    translate([ deer_mount_dx2/2, -deer_mount_dy2]) rotate([0, 0, 150])mount_boss();

    translate([-20,  13]) rotate([0, 0, 305]) clamp_boss();
    translate([ 20,  13]) rotate([0, 0, 235]) clamp_boss();
    translate([-35, -35]) rotate([0, 0,  30]) clamp_boss();
    translate([ 35, -35]) rotate([0, 0, 150]) clamp_boss();
    translate([-14, -70]) rotate([0, 0,  30]) clamp_boss();
    translate([ 14, -70]) rotate([0, 0, 150]) clamp_boss();

    linear_extrude(deer_base_h, scale=17/20) {
        circle(d=deer_base_d, $fs=nozzle_d/2);
    }
    translate([0, 0, deer_base_h]) {
        linear_extrude(deer_shaft_h) difference() {
            rotate([0, 0, angle]) intersection() {
                circle(d=deer_shaft_d, $fs=nozzle_d/2);
                square([deer_shaft_d-1.4, deer_shaft_d], center=true);
            }
            circle(d=4, $fs=nozzle_d/2);
        }
    }
    
}

color("white") deer_motor();
