using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Shared;

ISolver solver = new Day01();
solver.PrintSolutions("input.txt");

public class Day01 : ISolver
{
    public string SolveFirst(string inputFile)
    {
        IEnumerable<string> lines = File.ReadLines(inputFile);
        int? lastValue = null;
        var increases = 0;
        foreach (var line in lines)
        {
            var currentValue = int.Parse(line);

            if (lastValue < currentValue)
            {
                increases++;
            }

            lastValue = currentValue;
        }

        return $"{increases}";
    }

    public string SolveSecond(string inputFile)
    {
        IEnumerable<string> lines = File.ReadLines(inputFile);
        int? lastValue = null;
        var increases = 0;

        List<int> numbers = lines.Select(int.Parse).ToList();
        for (var i = 0; i < numbers.Count - 2; i++)
        {
            var currentValue = numbers[i] + numbers[i + 1] + numbers[i + 2];
            if (lastValue < currentValue)
            {
                increases++;
            }

            lastValue = currentValue;
        }

        return $"{increases}";
    }
}
