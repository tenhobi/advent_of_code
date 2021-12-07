using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Shared;

var solver = new Day07();
solver.PrintSolutions("input.txt");

public class Day07 : Solver
{
    public override string SolveFirst(string inputFile)
    {
        List<int> data = File.ReadLines(inputFile).ToList()[0].Split(",").Select(int.Parse).ToList();
        data.Sort();
        var median = data[data.Count / 2];
        var sum = data.Sum(i => Math.Abs(i - median));
        return sum.ToString();
    }

    public override string SolveSecond(string inputFile)
    {
        List<int> data = File.ReadLines(inputFile).ToList()[0].Split(",").Select(int.Parse).ToList();
        var min = data.Min();
        var max = data.Max();
        var bestSum = int.MaxValue;

        for (var center = min; center < max; center++)
        {
            var sum = 0;
            foreach (var difference in data.Select(value => Math.Abs(center - value)))
            {
                for (var j = 1; j <= difference; j++)
                {
                    sum += j;
                }
            }

            if (sum < bestSum) bestSum = sum;
            ;
        }

        return bestSum.ToString();
    }
}
