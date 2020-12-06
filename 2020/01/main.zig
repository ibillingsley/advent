const std = @import("std");
const print = std.debug.print;

const input_file = @embedFile("input.txt");
const target_sum = 2020;

fn parseInput(allocator: *std.mem.Allocator) ![]const i32 {
    var result = std.ArrayList(i32).init(allocator);
    errdefer result.deinit();
    var lines = std.mem.tokenize(input_file, "\n");
    while (lines.next()) |line| {
        const value = try std.fmt.parseInt(i32, line, 10);
        try result.append(value);
    }
    return result.toOwnedSlice();
}

fn part1(input: []const i32) ?i32 {
    var i: usize = 0;
    while (i < input.len) {
        var j: usize = i + 1;
        while (j < input.len) {
            if (input[i] + input[j] == target_sum) {
                return input[i] * input[j];
            }
            j += 1;
        }
        i += 1;
    }
    return null;
}

fn part2(input: []const i32) ?i32 {
    var i: usize = 0;
    while (i < input.len) {
        var j: usize = i + 1;
        while (j < input.len) {
            var k: usize = j + 1;
            while (k < input.len) {
                if (input[i] + input[j] + input[k] == target_sum) {
                    return input[i] * input[j] * input[k];
                }
                k += 1;
            }
            j += 1;
        }
        i += 1;
    }
    return null;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const input = try parseInput(&gpa.allocator);
    defer gpa.allocator.free(input);

    print("part 1: {}\n", .{part1(input)});
    print("part 2: {}\n", .{part2(input)});
}
