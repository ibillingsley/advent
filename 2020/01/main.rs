const TARGET_SUM: i32 = 2020;

fn part_1(input: &Vec<i32>) -> i32 {
    for i in 0..input.len() {
        for j in i..input.len() {
            if input[i] + input[j] == TARGET_SUM {
                return input[i] * input[j];
            }
        }
    }
    return -1;
}

fn part_2(input: &Vec<i32>) -> i32 {
    for i in 0..input.len() {
        for j in i..input.len() {
            for k in j..input.len() {
                if input[i] + input[j] + input[k] == TARGET_SUM {
                    return input[i] * input[j] * input[k];
                }
            }
        }
    }
    return -1;
}

fn main() {
    let input = std::fs::read_to_string("2020/01/input.txt")
        .unwrap()
        .lines()
        .map(|line| line.parse::<i32>().unwrap())
        .collect();

    println!("part 1: {}", part_1(&input));
    println!("part 2: {}", part_2(&input));
}
