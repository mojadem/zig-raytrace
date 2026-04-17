const std = @import("std");
const color = @import("Color.zig");
const Color = color.Color;

pub fn main() !void {
    var buf: [1024]u8 = undefined;
    var w = std.fs.File.stdout().writer(&buf);
    const stdout = &w.interface;
    const stderr = std.debug;

    const width = 256;
    const height = width;
    const max = width - 1;

    try stdout.print("P3\n{d} {d}\n{d}\n", .{ width, height, max });
    try stdout.flush();

    for (0..height) |j| {
        stderr.print("\r\x1b[KScanlines remaining: {d} ", .{height - j});
        for (0..width) |i| {
            const c = Color{
                .x = @as(f64, @floatFromInt(i)) / max,
                .y = @as(f64, @floatFromInt(j)) / max,
                .z = 0,
            };
            try color.writeColor(stdout, c);
            try stdout.print("\n", .{});
            try stdout.flush();
        }
    }
    stderr.print("\r\x1b[KDone.\n", .{});
}
