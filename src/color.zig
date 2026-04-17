const std = @import("std");
pub const Color = @import("Vec3.zig");

pub fn writeColor(
    writer: anytype,
    c: Color,
) !void {
    const scaled = c.scale(255.999);
    const r: u8 = @intFromFloat(scaled.x);
    const g: u8 = @intFromFloat(scaled.y);
    const b: u8 = @intFromFloat(scaled.z);
    try writer.print("{d} {d} {d}", .{ r, g, b });
}

test "format" {
    const c = Color{ .x = 1.0, .y = 0.0, .z = 1.0 };
    var buf: [32]u8 = undefined;
    var stream = std.io.fixedBufferStream(&buf);

    try writeColor(stream.writer(), c);

    try std.testing.expectEqualStrings("255 0 255", stream.getWritten());
}
