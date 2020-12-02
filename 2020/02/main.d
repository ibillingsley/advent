import std.stdio;

bool validate1(int min, int max, char c, string password)
{
	int count = 0;
	foreach (ch; password)
	{
		if (ch == c)
			count++;
	}
	return (count >= min && count <= max);
}

bool validate2(int x, int y, char c, string password)
{
	return (password[x - 1] == c) != (password[y - 1] == c);
}

void main()
{
	auto input = File("2020/02/input.txt").byRecord!(int, int, char, string)("%s-%s %s: %s");
	int answer1 = 0;
	int answer2 = 0;
	foreach (row; input)
	{
		if (validate1(row.expand))
			answer1++;
		if (validate2(row.expand))
			answer2++;
	}
	writeln("part 1: ", answer1);
	writeln("part 2: ", answer2);
}
