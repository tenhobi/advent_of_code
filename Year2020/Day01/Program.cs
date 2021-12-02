using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Shared;

Solver solver = new Day01();
solver.PrintSolutions("input.txt");

public class Day01 : Solver
{
    public override string SolveFirst(string inputFile)
    {
        List<int> numbers = File.ReadLines(inputFile).Select(int.Parse).ToList();

        foreach (var first in numbers)
        {
            foreach (var second in numbers.Where(second => first + second == 2020))
            {
                return (first * second).ToString();
            }
        }

        return "?";
    }

    public override string SolveSecond(string inputFile)
    {
        List<int> numbers = File.ReadLines(inputFile).Select(int.Parse).ToList();

        foreach (var first in numbers)
        {
            foreach (var second in numbers)
            {
                foreach (var third in numbers.Where(third => first + second + third == 2020))
                {
                    Console.WriteLine($"{first} + {second} + {third} == {first + second + third}");
                    return (first * second * third).ToString();
                }
            }
        }

        return "?";
    }
}