const std = @import("std");
const warn = std.debug.warn;

const input = @embedFile("input.txt");

fn validate1(min: u32, max: u32, char: u8, password: []const u8) bool {
    var count: u32 = 0;
    for (password) |c| {
        if (c == char) {
            count += 1;
        }
    }
    return count >= min and count <= max;
}

fn validate2(x: u32, y: u32, char: u8, password: []const u8) bool {
    return (password[x - 1] == char) != (password[y - 1] == char);
}

pub fn main() !void {
    var answer1: i32 = 0;
    var answer2: i32 = 0;
    var lines = std.mem.tokenize(input, "\n");
    while (lines.next()) |line| {
        var values = std.mem.tokenize(line, "- :");
        var x = try std.fmt.parseInt(u32, values.next().?, 10);
        var y = try std.fmt.parseInt(u32, values.next().?, 10);
        var char = values.next().?[0];
        var password = values.next().?;
        if (validate1(x, y, char, password)) answer1 += 1;
        if (validate2(x, y, char, password)) answer2 += 1;
    }
    warn("part 1: {}\n", .{answer1});
    warn("part 2: {}\n", .{answer2});
}
