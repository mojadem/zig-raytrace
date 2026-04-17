const Self = @This();
const T = f64;

x: T = 0,
y: T = 0,
z: T = 0,

pub fn add(self: Self, other: Self) Self {
    return .{ .x = self.x + other.x, .y = self.y + other.y, .z = self.z + other.z };
}

pub fn scale(self: Self, t: T) Self {
    return .{ .x = self.x * t, .y = self.y * t, .z = self.z * t };
}

pub fn div(self: Self, t: T) Self {
    return self.scale(1 / t);
}

pub fn negate(self: Self) Self {
    return self.scale(-1);
}

pub fn len_sq(self: Self) T {
    return self.x * self.x + self.y * self.y + self.z * self.z;
}

pub fn len(self: Self) T {
    return @sqrt(self.len_sq());
}

pub fn dot(self: Self, other: Self) T {
    return self.x * other.x + self.y * other.y + self.z * other.z;
}

pub fn cross(self: Self, other: Self) Self {
    return .{
        .x = self.y * other.z - self.z * other.y,
        .y = self.z * other.x - self.x * other.z,
        .z = self.x * other.y - self.y * other.x,
    };
}

pub fn unit(self: Self) Self {
    return self.div(self.len());
}

const std = @import("std");

fn expectEq(expected: T, actual: T) !void {
    try std.testing.expectApproxEqAbs(expected, actual, 1e-10);
}

test "add" {
    const a = Self{ .x = 1, .y = 2, .z = 3 };
    const b = Self{ .x = 4, .y = 5, .z = 6 };
    const result = a.add(b);
    try expectEq(5, result.x);
    try expectEq(7, result.y);
    try expectEq(9, result.z);
}

test "scale" {
    const v = Self{ .x = 1, .y = 2, .z = 3 };
    const result = v.scale(2);
    try expectEq(2, result.x);
    try expectEq(4, result.y);
    try expectEq(6, result.z);
}

test "div" {
    const v = Self{ .x = 2, .y = 4, .z = 6 };
    const result = v.div(2);
    try expectEq(1, result.x);
    try expectEq(2, result.y);
    try expectEq(3, result.z);
}

test "negate" {
    const v = Self{ .x = 1, .y = 2, .z = 3 };
    const result = v.negate();
    try expectEq(-1, result.x);
    try expectEq(-2, result.y);
    try expectEq(-3, result.z);
}

test "len_sq" {
    const v = Self{ .x = 2, .y = 0, .z = 0 };
    const result = v.len_sq();
    try expectEq(4, result);
}

test "len" {
    const v = Self{ .x = 2, .y = 0, .z = 0 };
    const result = v.len();
    try expectEq(2, result);
}

test "dot" {
    const a = Self{ .x = 1, .y = 2, .z = 3 };
    const b = Self{ .x = 4, .y = 5, .z = 6 };
    const result = a.dot(b);
    try expectEq(32, result);
}

test "cross" {
    const a = Self{ .x = 1, .y = 0, .z = 0 };
    const b = Self{ .x = 0, .y = 1, .z = 0 };
    const result = a.cross(b);
    try expectEq(0, result.x);
    try expectEq(0, result.y);
    try expectEq(1, result.z);
}

test "unit" {
    const v = Self{ .x = 3, .y = 0, .z = 0 };
    const result = v.unit();
    try expectEq(1, result.len());
}
