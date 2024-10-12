// HeaderPins renders 0.1" header pins, origin at the PCB top of the first pin
// Default sizes from https://cdn.shopify.com/s/files/1/0695/1347/8453/files/329006.pdf
module HeaderPins(qty, body=2.5, l1=3, l2=6, p=1.02, pitch=2.54) {    
    translate([0, 0, -l1]) difference() {
        for (i = [0:qty-1]) {
            x = i * pitch;
            difference() {
                // Pin
                translate([x - p/2, -p/2, 0]) cube([p, p, l1+l2+body]);
                // Short pin chamfers
                translate([x, 0, 0]) {
                    for (i=[0:90:315]) {
                        rotate([0,0,i])
                        translate([-p/2, p/2-0.2,0])
                        rotate([-30,0,0]) cube([p,0.5,0.5]);
                    }
                }
                // Long pin chamfers
                translate([x, 0, l1+l2+body]) {
                    for (i=[0:90:315]) {
                        rotate([0,0,i])
                        translate([-p/2, p/2-0.2,0])
                        rotate([-60,0,0]) cube([p,0.5,0.5]);
                    }
                }
            }
            // Plastic body
            translate([x, 0, l1+body/2]) cube([pitch,body,body], center=true);
        }    
        // Body chamfers
        for (i = [0:qty]) {
            x = i * pitch;
            translate([x-pitch/2, body/3, 0]) rotate(45) cube([1,1,10]);
            translate([x-pitch/2, -body/3, 0]) rotate(225) cube([1,1,10]);
        }
    }
}

// Example of 1 to 8 pin headers
for (i = [1:8]) {
    offset = (i-1)*5.08;
    translate([0, offset]) HeaderPins(i);
}
