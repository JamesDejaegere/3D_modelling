
// Parametrisch model gebaseerd op de aangeleverde schets
// Een lichte maar verstevigde haak / clip structuur
// Units = mm

$fn = 96;

// Algemene parameters
thickness = 16;
reinforcmentThickness= 8;
wall = 4;
fingerHoleDiameter=20;


// Buitencontour
module outer_shape() {
    translate([4.6,6.3])
        cube([6,wall, wall]);
    translate([0,4])
        cylinder(h=wall,r=4);
    polygon(points=[
        [0,0],
        [17,0],
        [17,4],
        [24,8]
        ]);
}

// Binnenuitsparing om gewicht te besparen
module inner_cutout() {
    offset(r=-wall)
      outer_shape();
  
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
        translate([8,-2]) circle(r=fingerHoleDiameter);
        translate([8,-2]) circle(r=fingerHoleDiameter-wall);
    }

    // rechts
    difference() {
        translate([92,0]) circle(r=fingerHoleDiameter);
        translate([92,0]) circle(r=fingerHoleDiameter-wall);
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
outer_shape();

difference() {
    union() {
        difference() {
            outer_shape();
//            inner_cutout();
        }
//
//        reinforced_holes();
////        top_boss();
    }
//
//    // Doorlopende gaten
////    translate([8,-2]) circle(r=9);
////    translate([92,0]) circle(r=9);
//
//    // Haakopening
////    hook_cutout();
}
