const std = @import("std");
const print = std.debug.print;

const input = @embedFile("input.txt");

pub fn main() !void {
    var answer1: u32 = 0;
    var answer2: u32 = 0;
    var groups = std.mem.split(input, "\n\n");
    while (groups.next()) |group| {
        var yesAnswers = [_]u32{0} ** 26;
        var groupLen: u32 = 0;
        var people = std.mem.tokenize(group, "\n");
        while (people.next()) |person| {
            for (person) |c| {
                yesAnswers[c - 'a'] += 1;
            }
            groupLen += 1;
        }
        for (yesAnswers) |count| {
            if (count > 0) answer1 += 1;
            if (count == groupLen) answer2 += 1;
        }
    }
    print("part 1: {}\n", .{answer1});
    print("part 2: {}\n", .{answer2});
}
