use <squircle.scad>
$fs = 0.1;

module icebox_cover_v2(chip = [8, 8, 1], count = [1, 1], error = 0) {

  assert(chip[0] > 0, "chip package width could not be 0.");
  assert(chip[1] > 0, "chip package height could not be 0.");
  assert(chip[2] > 0, "chip package thickness could not be 0.");

  assert(count[0] > 0, "row could not be 0.");
  assert(count[1] > 0, "column could not be 0.");

  // chip box size
  chip_x = chip[0];
  chip_y = chip[1];
  chip_margin  = 1;
  chip_padding = 4;

  // top cover size
  size_fixed_z = 1;
  size_x = ((chip[0] + chip_margin) * count[0]) + chip_padding * 2 - chip_margin;
  size_y = ((chip[1] + chip_margin) * count[1]) + chip_padding * 2 - chip_margin;
  size_z = size_fixed_z;

  // body
  difference() {
    translate([0, 0, 0])
    squircle([size_x, size_y, size_z + 2], 2);

    translate([2 - error, 2 - error, size_z])
    cube([size_x + error * 2, size_y - 4 + error * 2, 2]);
  }

  // slider slot
  translate([0, 2 - error, size_z + 2])
    rotate([225, 0, 0])
      cube([size_x - .2, 1, 1]);
  translate([0, size_y - 2 + error, size_z + 2])
    rotate([225, 0, 0])
      cube([size_x - .2, 1, 1]);
}
