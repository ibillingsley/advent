const std = @import("std");
const print = std.debug.print;

const input = @embedFile("input.txt");

pub fn main() !void {
    var answer1: u32 = 0;
    var answer2: u32 = 0;
    var groups = std.mem.split(input, "\n\n");
    while (groups.next()) |group| {
        var yes_answers = [_]u32{0} ** 26;
        var group_len: u32 = 0;
        var people = std.mem.tokenize(group, "\n");
        while (people.next()) |person| {
            for (person) |c| {
                yes_answers[c - 'a'] += 1;
            }
            group_len += 1;
        }
        for (yes_answers) |count| {
            if (count > 0) answer1 += 1;
            if (count == group_len) answer2 += 1;
        }
    }
    print("part 1: {}\n", .{answer1});
    print("part 2: {}\n", .{answer2});
}
