
// Parametrisch model gebaseerd op de aangeleverde schets
// Een lichte maar verstevigde haak / clip structuur
// Units = mm

$fn = 96;

// Algemene parameters
thickness = 6;
wall = 3;

// Buitencontour
module outer_shape() {
    hull() {
        translate([0,0]) circle(r=38);
        translate([92,2]) circle(r=28);
        translate([35,48]) circle(r=24);
    }
}

// Binnenuitsparing om gewicht te besparen
module inner_cutout() {
    offset(r=-wall)
    hull() {
        translate([0,0]) circle(r=38);
        translate([92,2]) circle(r=28);
        translate([35,48]) circle(r=24);
    }
}

// Haakopening bovenaan
module hook_cutout() {
    difference() {
        offset(r=4)
        polygon(points=[
            [18,28],
            [48,28],
            [64,45],
            [56,52],
            [45,42],
            [18,42]
        ]);

        polygon(points=[
            [20,31],
            [46,31],
            [58,44],
            [54,47],
            [44,38],
            [20,38]
        ]);
    }
}

// Verstevigde gaten
module reinforced_holes() {
    // links
    difference() {
        translate([8,-2]) circle(r=14);
        translate([8,-2]) circle(r=9);
    }

    // rechts
    difference() {
        translate([92,0]) circle(r=14);
        translate([92,0]) circle(r=9);
    }
}

// Klein centraal verstevigingspunt
module top_boss() {
    translate([63,18])
    difference() {
        circle(r=6);
        circle(r=3);
    }
}

// Hoofdmodel
linear_extrude(height=thickness)
difference() {
    union() {
        difference() {
            outer_shape();
            inner_cutout();
        }

        reinforced_holes();
        top_boss();
    }

    // Doorlopende gaten
    translate([8,-2]) circle(r=9);
    translate([92,0]) circle(r=9);

    // Haakopening
    hook_cutout();
}
