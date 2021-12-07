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
        var mean = (int)Math.Round(data.Sum() / (decimal)data.Count);
        Console.WriteLine(mean);
        var sum = data.Sum(i =>
        {
            var subSum = 0;
            for (var j = 1; j <= Math.Abs(i - mean); j++)
            {
                subSum += j;
            }

            return subSum;
        });

        return sum.ToString();
    }
}