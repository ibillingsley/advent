const std = @import("std");
const print = std.debug.print;

const input = @embedFile("input.txt");
const rows = 128;
const columns = 8;
var seats = [_]bool{false} ** (rows * columns);

fn binSearch(path: []const u8, n: u32) u32 {
    var low: u32 = 0;
    var high: u32 = n;
    for (path) |c| {
        const mid = (low + high) / 2;
        switch (c) {
            'B', 'R' => {
                low = mid;
            },
            'F', 'L' => {
                high = mid;
            },
            else => unreachable,
        }
    }
    return low;
}

fn part1() u32 {
    var max_seat_id: u32 = 0;
    var lines = std.mem.tokenize(input, "\n");
    while (lines.next()) |line| {
        const row = binSearch(line[0..7], rows);
        const col = binSearch(line[7..], columns);
        const seat_id = row * columns + col;
        seats[seat_id] = true;
        max_seat_id = std.math.max(max_seat_id, seat_id);
    }
    return max_seat_id;
}

fn part2() ?u32 {
    var i: u32 = 1;
    while (i < seats.len - 1) {
        if (!seats[i] and seats[i - 1] and seats[i + 1]) {
            return i;
        }
        i += 1;
    }
    return null;
}

pub fn main() !void {
    print("part 1: {}\n", .{part1()});
    print("part 2: {}\n", .{part2()});
}
