const std = @import("std");
const warn = std.debug.warn;

const input_file = @embedFile("input.txt");
const Passport = std.StringHashMap([]const u8);

fn parseInput(allocator: *std.mem.Allocator) ![]Passport {
    var passports = std.ArrayList(Passport).init(allocator);
    errdefer passports.deinit();
    var input = std.mem.split(input_file, "\n\n");
    while (input.next()) |data| {
        var passport = Passport.init(allocator);
        errdefer passport.deinit();
        var key_value_pairs = std.mem.tokenize(data, " \n");
        while (key_value_pairs.next()) |key_value| {
            const index = std.mem.indexOfScalar(u8, key_value, ':').?;
            const key = key_value[0..index];
            const value = key_value[(index + 1)..];
            try passport.put(key, value);
        }
        try passports.append(passport);
    }
    return passports.toOwnedSlice();
}

fn hasRequiredFields(passport: Passport) bool {
    const fields = [_][]const u8{ "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" };
    for (fields) |field| {
        if (!passport.contains(field)) return false;
    }
    return true;
}

fn inRange(value: []const u8, min: i32, max: i32) bool {
    const int_value = std.fmt.parseInt(i32, value, 10) catch return false;
    return int_value >= min and int_value <= max;
}

fn validate_byr(value: []const u8) bool {
    return inRange(value, 1920, 2002);
}

fn validate_iyr(value: []const u8) bool {
    return inRange(value, 2010, 2020);
}

fn validate_eyr(value: []const u8) bool {
    return inRange(value, 2020, 2030);
}

fn validate_hgt(value: []const u8) bool {
    if (std.mem.endsWith(u8, value, "cm")) {
        return inRange(value[0 .. value.len - 2], 150, 193);
    }
    if (std.mem.endsWith(u8, value, "in")) {
        return inRange(value[0 .. value.len - 2], 59, 76);
    }
    return false;
}

fn validate_hcl(value: []const u8) bool {
    if ((value[0] == '#') and (value.len == 7)) {
        _ = std.fmt.parseInt(u32, value[1..], 16) catch return false;
        return true;
    }
    return false;
}

fn validate_ecl(value: []const u8) bool {
    const colors = [_][]const u8{ "amb", "blu", "brn", "gry", "grn", "hzl", "oth" };
    for (colors) |color| {
        if (std.mem.eql(u8, color, value)) return true;
    }
    return false;
}

fn validate_pid(value: []const u8) bool {
    if (value.len == 9) {
        _ = std.fmt.parseInt(u32, value, 10) catch return false;
        return true;
    }
    return false;
}

fn validate(passport: Passport) bool {
    return validate_byr(passport.get("byr").?) and
        validate_iyr(passport.get("iyr").?) and
        validate_eyr(passport.get("eyr").?) and
        validate_hgt(passport.get("hgt").?) and
        validate_hcl(passport.get("hcl").?) and
        validate_ecl(passport.get("ecl").?) and
        validate_pid(passport.get("pid").?);
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var passports = try parseInput(&gpa.allocator);
    defer gpa.allocator.free(passports);
    defer for (passports) |*passport| passport.deinit();

    var answer1: i32 = 0;
    var answer2: i32 = 0;
    for (passports) |passport| {
        if (hasRequiredFields(passport)) {
            answer1 += 1;
            if (validate(passport)) answer2 += 1;
        }
    }
    warn("part 1: {}\n", .{answer1});
    warn("part 2: {}\n", .{answer2});
}