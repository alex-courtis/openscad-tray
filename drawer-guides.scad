include <BOSL2/std.scad>

// bottom sides
// size = [269, 10.5, 55];
// top = 1.8;
// ribs = 4;
//
// t_top = 1.8;
// t_bottom = 1.8;
// t_wall = 1.2;
// t_rib = 1.8;
//
// chamfer = 1.8;

// bottom back, fits between sides
size = [273, 7, 63];
top = 7;
ribs = 4;
tape = 6;

t_top = 1.8;
t_bottom = 1.8;
t_wall = 0.9;
t_rib = 1.8;

chamfer = 1.2;

d_hole = 2.0;

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
    dz = -t_top - t_bottom - (is_undef(tape) ? 0 : tape);

    intersection() {
      translate(v=[0, 0, t_bottom])
        cube(size=size + [0, 0, dz], center=false);

      translate(v=[0, -t_wall / cos(a), 0])
        rotate(a=90, v=[0, 1, 0])
          linear_extrude(h=x_hollow, center=false)
            polygon(poly_cross);
    }
  }

  module holes() {
    for (
      x = [t_rib / 2, size.x - t_rib / 2],
      z = [
        t_bottom + d_hole / 2 + d_hole,
        size.z / 2 - (is_undef(tape) ? 0 : tape) / 2,
        size.z - t_top - d_hole / 2 - d_hole - (is_undef(tape) ? 0 : tape),
      ]
    )
      translate(v=[x, top / 2, z])
        rotate(a=90, v=[0, 0, 1])
          teardrop(h=t_rib, d=d_hole, ang=60, orient=LEFT);
  }

  difference() {
    whole();

    for (dx = [t_rib:x_hollow + t_rib:size.x - t_rib]) {
      translate(v=[dx, 0, 0])
        hollow();
    }

    if (!is_undef(d_hole)) {
      holes();
    }
  }
}

render() {
  divider();
}
