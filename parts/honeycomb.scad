module outline(th) {
    difference() {
        offset(delta= th/2) children();
        offset(delta=-th/2) children();
    }
}

module honeycomb(w, h, d, th, center=false) {
    dx = d * (1+cos(60));
    dy = d * cos(30);
    x0 = -floor(w/2/dx+0.5)*dx + (center ? 0 : w/2);
    y0 = -floor(h/2/dy+0.5)*dy + (center ? 0 : h/2);

    for (y=[y0:dy:y0+h+dy]) {
        for (x=[x0:dx:x0+w+dx]) {
            translate([x, y])
                outline(th) circle(d=d, $fn=6);
        }
    }
    for (y=[y0+dy/2:dy:y0+h+dy]) {
        for (x=[x0+dx/2:dx:x0+w+dx]) {
            translate([x, y])
                outline(th) circle(d=d, $fn=6);
        }
    }
}

module bounded_honeycomb(w, h, d, th, center=false) {
    intersection() {
        honeycomb(w, h, d, th, center);
        children();
    }
    difference() {
       children();
       offset(delta=-th) children();
    }
}

$fn=60;
module test_plate() {
    linear_extrude(2, convexity=10) {
        difference() {
            bounded_honeycomb(80, 60, 6, 0.8, center=true) {
                hull() {
                    translate([ 0, 0]) circle(d=20);
                    translate([ 20, 0]) circle(d=15);
                }
            }
            children();
        }
        for (i=[0:$children-1]) outline(0.8) children(i);
    }
}

test_plate() {
    union() {
        translate([5, 2]) circle(d=8);
        translate([8, -3]) circle(d=9);
    }
}
