import { readFileSync } from "fs";

const input = readFileSync("2020/04/input.txt")
	.toString()
	.trim()
	.split("\n\n")
	.map((passport) =>
		passport.split(/\s+/).reduce((data, keyValue) => {
			const [key, value] = keyValue.split(":");
			data[key] = value;
			return data;
		}, {})
	);

function inRange(value, min, max) {
	value = parseInt(value);
	return value >= min && value <= max;
}

const validators = {
	byr: (value) => inRange(value, 1920, 2002),
	iyr: (value) => inRange(value, 2010, 2020),
	eyr: (value) => inRange(value, 2020, 2030),
	hgt: (value) => {
		if (value.endsWith("cm")) return inRange(value, 150, 193);
		if (value.endsWith("in")) return inRange(value, 59, 76);
		return false;
	},
	hcl: (value) => /^#[0-9a-f]{6}$/.test(value),
	ecl: (value) => ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].includes(value),
	pid: (value) => /^[0-9]{9}$/.test(value),
};

const requiredFields = Object.keys(validators);

let answer1 = 0;
let answer2 = 0;
for (const passport of input) {
	if (requiredFields.every((field) => passport[field])) {
		answer1++;
		if (requiredFields.every((field) => validators[field](passport[field]))) {
			answer2++;
		}
	}
}

console.log("part 1: " + answer1);
console.log("part 2: " + answer2);
