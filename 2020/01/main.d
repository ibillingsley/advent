import std.algorithm;
import std.array;
import std.conv;
import std.stdio;

const targetSum = 2020;

int part1(int[] input)
{
	for (int i = 0; i < input.length; i++)
	{
		for (int j = i + 1; j < input.length; j++)
		{
			if (input[i] + input[j] == targetSum)
			{
				return input[i] * input[j];
			}
		}
	}
	return -1;
}

int part2(int[] input)
{
	for (int i = 0; i < input.length; i++)
	{
		for (int j = i + 1; j < input.length; j++)
		{
			for (int k = j + 1; k < input.length; k++)
			{
				if (input[i] + input[j] + input[k] == targetSum)
				{
					return input[i] * input[j] * input[k];
				}
			}
		}
	}
	return -1;
}

void main()
{
	auto input = File("2020/01/input.txt").byLine().map!(line => line.to!int).array();
	writeln("part 1: ", part1(input));
	writeln("part 2: ", part2(input));
}
