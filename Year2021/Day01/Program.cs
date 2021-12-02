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
        List<int> numbers = File.ReadLines(inputFile).Select(int.Parse).ToList();
        var increases = numbers.Zip(numbers.Skip(1)).Count(tuple => tuple.First < tuple.Second);
        return increases.ToString();
    }

    public string SolveSecond(string inputFile)
    {
        List<int> numbers = File.ReadLines(inputFile).Select(int.Parse).ToList();
        var numbersInGroup = numbers.Zip(numbers.Skip(1), numbers.Skip(2))
            .Select(tuple => tuple.First + tuple.Second + tuple.Third).ToList();
        var increases = numbersInGroup.Zip(numbersInGroup.Skip(1)).Count(tuple => tuple.First < tuple.Second);
        return increases.ToString();
    }
}
