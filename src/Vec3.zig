const Vec3 = @This();

x: f64 = 0,
y: f64 = 0,
z: f64 = 0,

pub fn add(self: Vec3, other: Vec3) Vec3 {
    return .{ .x = self.x + other.x, .y = self.y + other.y, .z = self.z + other.z };
}

pub fn scale(self: Vec3, t: f64) Vec3 {
    return .{ .x = self.x * t, .y = self.y * t, .z = self.z * t };
}

pub fn div(self: Vec3, t: f64) Vec3 {
    return self.scale(1 / t);
}

pub fn negate(self: Vec3) Vec3 {
    return self.scale(-1);
}

pub fn len_sq(self: Vec3) f64 {
    return self.x * self.x + self.y * self.y + self.z * self.z;
}

pub fn len(self: Vec3) f64 {
    return @sqrt(self.len_sq());
}

pub fn dot(self: Vec3, other: Vec3) f64 {
    return self.x * other.x + self.y * other.y + self.z * other.z;
}

pub fn cross(self: Vec3, other: Vec3) Vec3 {
    return .{
        .x = self.y * other.z - self.z * other.y,
        .y = self.z * other.x - self.x * other.z,
        .z = self.x * other.y - self.y * other.x,
    };
}

pub fn unit(self: Vec3) Vec3 {
    return self.div(self.len());
}

const std = @import("std");

fn expectEq(expected: f64, actual: f64) !void {
    try std.testing.expectApproxEqAbs(expected, actual, 1e-10);
}

test "add" {
    const a = Vec3{ .x = 1, .y = 2, .z = 3 };
    const b = Vec3{ .x = 4, .y = 5, .z = 6 };
    const result = a.add(b);
    try expectEq(5, result.x);
    try expectEq(7, result.y);
    try expectEq(9, result.z);
}

test "scale" {
    const v = Vec3{ .x = 1, .y = 2, .z = 3 };
    const result = v.scale(2);
    try expectEq(2, result.x);
    try expectEq(4, result.y);
    try expectEq(6, result.z);
}

test "div" {
    const v = Vec3{ .x = 2, .y = 4, .z = 6 };
    const result = v.div(2);
    try expectEq(1, result.x);
    try expectEq(2, result.y);
    try expectEq(3, result.z);
}

test "negate" {
    const v = Vec3{ .x = 1, .y = 2, .z = 3 };
    const result = v.negate();
    try expectEq(-1, result.x);
    try expectEq(-2, result.y);
    try expectEq(-3, result.z);
}

test "len_sq" {
    const v = Vec3{ .x = 2, .y = 0, .z = 0 };
    const result = v.len_sq();
    try expectEq(4, result);
}

test "len" {
    const v = Vec3{ .x = 2, .y = 0, .z = 0 };
    const result = v.len();
    try expectEq(2, result);
}

test "dot" {
    const a = Vec3{ .x = 1, .y = 2, .z = 3 };
    const b = Vec3{ .x = 4, .y = 5, .z = 6 };
    const result = a.dot(b);
    try expectEq(32, result);
}

test "cross" {
    const a = Vec3{ .x = 1, .y = 0, .z = 0 };
    const b = Vec3{ .x = 0, .y = 1, .z = 0 };
    const result = a.cross(b);
    try expectEq(0, result.x);
    try expectEq(0, result.y);
    try expectEq(1, result.z);
}

test "unit" {
    const v = Vec3{ .x = 3, .y = 0, .z = 0 };
    const result = v.unit();
    try expectEq(1, result.len());
}
