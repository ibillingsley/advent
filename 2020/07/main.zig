const std = @import("std");
const print = std.debug.print;

const input_file = @embedFile("input.txt");

const BagRule = struct {
    count: u32, color: []const u8
};

fn parseInput(allocator: *std.mem.Allocator) !std.StringHashMap([]BagRule) {
    var bag_map = std.StringHashMap([]BagRule).init(allocator);
    errdefer bag_map.deinit();
    var input = std.mem.tokenize(input_file, "\n");
    while (input.next()) |line| {
        const delim = " bags contain";
        const color_end_index = std.mem.indexOf(u8, line, delim).?;
        const parent_color = line[0..color_end_index];

        var rules = std.ArrayList(BagRule).init(allocator);
        errdefer rules.deinit();

        var child_iter = std.mem.split(line[(color_end_index + delim.len)..], " bag");
        while (child_iter.next()) |child| {
            var word_iter = std.mem.split(child, " ");
            _ = word_iter.next(); // leading "" or "s," or "s." or "," or "."
            if (word_iter.next()) |count_str| {
                const count = std.fmt.parseUnsigned(u32, count_str, 10) catch continue;
                const child_color = child[(word_iter.index.?)..];
                try rules.append(BagRule{
                    .count = count,
                    .color = child_color,
                });
            }
        }
        try bag_map.put(parent_color, rules.toOwnedSlice());
    }
    return bag_map;
}

fn contains(bag_map: std.StringHashMap([]BagRule), parent: []const u8, target: []const u8) bool {
    for (bag_map.get(parent).?) |child| {
        if (std.mem.eql(u8, child.color, target) or contains(bag_map, child.color, target)) {
            return true;
        }
    }
    return false;
}

fn countChildren(bag_map: std.StringHashMap([]BagRule), parent: []const u8) u32 {
    var count: u32 = 0;
    for (bag_map.get(parent).?) |child| {
        count += child.count * (countChildren(bag_map, child.color) + 1);
    }
    return count;
}

fn part1(bag_map: std.StringHashMap([]BagRule)) u32 {
    var answer: u32 = 0;
    var iter = bag_map.iterator();
    while (iter.next()) |key_value| {
        if (contains(bag_map, key_value.key, "shiny gold")) answer += 1;
    }
    return answer;
}

fn part2(bag_map: std.StringHashMap([]BagRule)) u32 {
    return countChildren(bag_map, "shiny gold");
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var arena = std.heap.ArenaAllocator.init(&gpa.allocator);
    defer arena.deinit();

    var bag_map = try parseInput(&arena.allocator);

    print("part 1: {}\n", .{part1(bag_map)});
    print("part 2: {}\n", .{part2(bag_map)});
}
