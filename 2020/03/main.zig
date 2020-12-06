const std = @import("std");
const print = std.debug.print;

const input = @embedFile("input.txt");
const width = std.mem.indexOfScalar(u8, input, '\n').?;

fn countTrees(dx: u8, dy: u8) i32 {
    var count: i32 = 0;
    var x: usize = 0;
    var y: usize = 0;
    var i: usize = 0;
    while (i < input.len) {
        if (input[i] == '#') {
            count += 1;
        }
        x += dx;
        y += dy;
        i = (x % width) + y * (width + 1);
    }
    return count;
}

fn part1() i32 {
    return countTrees(3, 1);
}

fn part2() i32 {
    const slopes = [_][2]u8{
        [_]u8{ 1, 1 },
        [_]u8{ 3, 1 },
        [_]u8{ 5, 1 },
        [_]u8{ 7, 1 },
        [_]u8{ 1, 2 },
    };
    var answer: i32 = 1;
    for (slopes) |slope| {
        answer *= countTrees(slope[0], slope[1]);
    }
    return answer;
}

pub fn main() !void {
    print("part 1: {}\n", .{part1()});
    print("part 2: {}\n", .{part2()});
}
