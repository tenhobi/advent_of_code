using System.Collections.Generic;
using System.IO;
using System.Linq;
using Shared;

ISolver solver = new Day02();
solver.PrintSolutions("input.txt");

public class Day02 : ISolver
{
    public string SolveFirst(string inputFile)
    {
        List<string> data = File.ReadLines(inputFile).ToList();
        int horizontalPosition = 0;
        int depth = 0;

        data.ForEach(s =>
        {
            var x = s.Split(" ");
            var value = int.Parse(x[1]);

            switch (x[0])
            {
                case "forward":
                    horizontalPosition += value;
                    break;
                case "down":
                    depth += value;
                    break;
                case "up":
                    depth -= value;
                    break;
            }
        });

        return (depth * horizontalPosition).ToString();
    }

    public string SolveSecond(string inputFile)
    {
        List<string> data = File.ReadLines(inputFile).ToList();
        int horizontalPosition = 0;
        int depth = 0;
        int aim = 0;

        data.ForEach(s =>
        {
            var x = s.Split(" ");
            var value = int.Parse(x[1]);

            switch (x[0])
            {
                case "forward":
                    horizontalPosition += value;
                    depth += aim * value;
                    break;
                case "down":
                    aim += value;
                    break;
                case "up":
                    aim -= value;
                    break;
            }
        });

        return (depth * horizontalPosition).ToString();
    }
}