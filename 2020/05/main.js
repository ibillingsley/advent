import { readFileSync } from "fs";

const input = readFileSync("2020/05/input.txt").toString().trim().split("\n");
const rows = 128;
const columns = 8;
const seats = Array(rows * columns).fill(false);

function binSearch(path, high) {
	let low = 0;
	for (const c of path) {
		const mid = (low + high) / 2;
		if (c === "B" || c === "R") {
			low = mid;
		} else if (c === "F" || c === "L") {
			high = mid;
		}
	}
	return low;
}

function part1() {
	let maxSeatId = 0;
	for (const line of input) {
		const row = binSearch(line.substring(0, 7), rows);
		const col = binSearch(line.substring(7), columns);
		const seatId = row * columns + col;
		seats[seatId] = true;
		maxSeatId = Math.max(maxSeatId, seatId);
	}
	return maxSeatId;
}

function part2() {
	for (let i = 1; i < seats.length - 1; i++) {
		if (!seats[i] && seats[i - 1] && seats[i + 1]) {
			return i;
		}
	}
}

console.log("part 1: " + part1());
console.log("part 2: " + part2());
