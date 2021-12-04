using System.Collections.Generic;
using System.IO;
using System.Linq;
using Shared;

var solver = new Day18();
solver.PrintSolutions("input.txt");

public class Day18 : Solver
{
    public override string SolveFirst(string inputFile)
    {
        List<string> data = File.ReadLines(inputFile).ToList();
        return "?";
    }

    public override string SolveSecond(string inputFile)
    {
        List<string> data = File.ReadLines(inputFile).ToList();
        return "?";
    }
}