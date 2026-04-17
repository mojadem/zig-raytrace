const Self = @This();

const Vec3 = @import("Vec3.zig");
const Point3 = Vec3;

const T = f64;

origin: Point3,
dir: Vec3,

pub fn at(self: Self, t: T) Point3 {
    return self.origin.add(self.dir.scale(t));
}

const std = @import("std");

test "at" {
    const r = Self{
        .origin = Point3{ .x = 0, .y = 0, .z = 0 },
        .dir = Vec3{ .x = 1, .y = 0, .z = 0 },
    };

    const result = r.at(2);

    try std.testing.expectApproxEqAbs(2, result.x, 1e-10);
    try std.testing.expectApproxEqAbs(0, result.y, 1e-10);
    try std.testing.expectApproxEqAbs(0, result.z, 1e-10);
}
