use <../lib/icebox-v2.scad>
use <../lib/icebox-cover-v2.scad>

chip_x = 8;
chip_y = 8;
chip_z = 1;
box_size = [4, 4];
print_error = 0.1;

icebox_v2(
  chip   = [chip_x, chip_y, chip_z],
  count  = box_size,
  base_height = 6,
  magnet = [6, 3],
  error = print_error
);

translate([50, 0, 0])
icebox_cover_v2(
  chip   = [chip_x, chip_y, chip_z],
  count  = box_size,
  error  = print_error
);
