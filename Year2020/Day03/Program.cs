using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Shared;

var solver = new Day03();
solver.PrintSolutions("input.txt");

public class Day03 : Solver
{
    public override string SolveFirst(string inputFile)
    {
        List<string> lines = File.ReadLines(inputFile).ToList();

        int posX = 0;
        (int, int) slope = (3, 1);
        int width = lines[0].Length;
        int counter = 0;

        foreach (var line in lines)
        {
            if (line[posX % width] == '#')
            {
                counter++;
            }

            posX += slope.Item1;
        }

        return counter.ToString();
    }

    public override string SolveSecond(string inputFile)
    {
        List<string> lines = File.ReadLines(inputFile).ToList();
        List<(int, int)> slopes = new(
            new[] { (1, 1), (3, 1), (5, 1), (7, 1), (1, 2) });
        int width = lines[0].Length;
        Int64 counterProduct = 1;

        foreach (var slope in slopes)
        {
            var position = (0, 0);
            var counter = 0;

            while (position.Item2 < lines.Count)
            {
                var line = lines[position.Item2];
                if (line[position.Item1] == '#')
                {
                    counter++;
                }

                position = (position.Item1 + slope.Item1, position.Item2 + slope.Item2);
                position.Item1 %= width;
            }

            counterProduct *= counter;
        }

        return counterProduct.ToString();
    }
}
