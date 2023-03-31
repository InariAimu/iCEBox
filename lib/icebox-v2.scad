use <squircle.scad>
$fs = 0.1;

module icebox_v2(chip = [8, 8, 1], count = [1, 1], base_height = 3, magnet = [0, 0], error = 0) {

  assert(chip[0] > 0, "chip package width could not be 0.");
  assert(chip[1] > 0, "chip package height could not be 0.");
  assert(chip[2] > 0, "chip package thickness could not be 0.");

  assert(count[0] > 0, "row could not be 0.");
  assert(count[1] > 0, "column could not be 0.");

  // chip box size
  chip_x = chip[0];
  chip_y = chip[1];
  chip_z = chip[2];
  chip_margin  = 1;
  chip_padding = 4;

  // bottom pad size
  size_fixed_z = base_height;
  size_x = ((chip[0] + chip_margin) * count[0]) + chip_padding * 2 - chip_margin;
  size_y = ((chip[1] + chip_margin) * count[1]) + chip_padding * 2 - chip_margin;
  size_z = chip_z + size_fixed_z;

  // chip tray
  difference() {

    // body
    translate([0, 0, 0])
    squircle([size_x, size_y, size_z], 2);

    // grids
    for(x = [0 : count[0] - 1]) for(y = [0 : count[1] - 1]) {
      translate([chip_padding + chip_x * x + (chip_margin * x) - error, chip_padding + chip_y * y + (chip_margin * y) - error, size_fixed_z])
      cube([chip_x + error * 2, chip_y + error * 2, chip_z + 1]);
    }

    // fidual mark
    translate([chip_padding - 1, chip_padding - 1, size_z - 0.5])
        cylinder(d = 1 + error, h = 1);

    translate([chip_padding - 1, size_y - chip_padding + 1, size_z - 0.5])
        cylinder(d = 1 + error, h = 1);

    translate([size_x - chip_padding + 1, chip_padding - 1, size_z - 0.5])
        cylinder(d = 1 + error, h = 1);

    // silder slot
    translate([0, 0, size_z - 2])
        cube([size_x, 2, 2]);
    translate([0, 2, size_z - 2])
        rotate([45, 0, 0])
            cube([size_x, 1, 1]);

    translate([0, size_y - 2, size_z - 2])
        cube([size_x, 2, 2]);
    translate([0, size_y - 2, size_z - 2])
        rotate([45, 0, 0])
            cube([size_x, 1, 1]);

    translate([size_x - 2, 2, size_z - 2])
        cube([2, size_y, 2]);

    // mag insert
    if(magnet[0] > 0 && magnet[1] > 0 && base_height > magnet[1] + 1) {
        for(x = [0 : 1]) for(y = [0 : 1]) {
          translate([chip_padding + (size_x - chip_padding * 2) * x, chip_padding + (size_y - chip_padding * 2) * y, 0])
            cylinder(d = magnet[0] + error * 2, h = magnet[1] + error);
        }
    }
  }
  
}
