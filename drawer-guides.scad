include <BOSL2/std.scad>

size = [267, 9.5, 53];
top = 3;
ribs = 3;

t_top = 1.8;
t_bottom = 1.8;
t_wall = 0.9;
t_rib = 1.8;

chamfer = 1.8;

a = 90 - atan(size.z / (size.y - top));

poly_cross = [
  [0, 0],
  [0, size.y],
  [-size.z, top],
  [-size.z, 0],
];

$fn = 200;

module divider() {
  x_hollow = (size.x - t_rib * (ribs + 2)) / (ribs + 1);

  module whole() {
    difference() {
      intersection() {
        rotate(a=90, v=[0, 1, 0])
          linear_extrude(h=size.x, center=false)
            polygon(poly_cross);

        // chamfer most
        cuboid(
          size=size,
          anchor=BOTTOM + LEFT + FRONT,
          chamfer=chamfer,
          except=[BACK + LEFT, BACK + RIGHT],
        );
      }

      // chamfer top walls
      translate(v=[0, top + chamfer * tan(a), size.z])
        chamfer_edge_mask(l=size.x, chamfer=chamfer, orient=LEFT, anchor=UP, excess=0);
    }
  }

  module hollow() {
    intersection() {
      translate(v=[0, 0, t_bottom])
        cube(size=size - [0, 0, t_top + t_bottom], center=false);

      translate(v=[0, -t_wall / cos(a), 0])
        rotate(a=90, v=[0, 1, 0])
          linear_extrude(h=x_hollow, center=false)
            polygon(poly_cross);
    }
  }

  difference() {
    whole();

    for (dx = [t_rib:x_hollow + t_rib:size.x - t_rib]) {
      translate(v=[dx, 0, 0])
        hollow();
    }
  }
}

render() {
  divider();
}
