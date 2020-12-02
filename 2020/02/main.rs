fn validate_1(min: usize, max: usize, c: char, password: &str) -> bool {
	let mut count: usize = 0;
	for ch in password.chars() {
		if ch == c {
			count += 1;
		}
	}
	return count >= min && count <= max;
}

fn validate_2(x: usize, y: usize, c: char, password: &str) -> bool {
	let password: Vec<char> = password.chars().collect();
	return (password[x - 1] == c) != (password[y - 1] == c);
}

fn main() {
	let input = std::fs::read_to_string("2020/02/input.txt").unwrap();
	let mut answer_1: i32 = 0;
	let mut answer_2: i32 = 0;
	for line in input.lines() {
		let mut values = line.split(['-', ' '].as_ref());
		let x = values.next().unwrap().parse::<usize>().unwrap();
		let y = values.next().unwrap().parse::<usize>().unwrap();
		let c = values.next().unwrap().chars().next().unwrap();
		let password = values.next().unwrap();
		if validate_1(x, y, c, password) {
			answer_1 += 1;
		}
		if validate_2(x, y, c, password) {
			answer_2 += 1;
		}
	}
	println!("part 1: {}", answer_1);
	println!("part 2: {}", answer_2);
}
