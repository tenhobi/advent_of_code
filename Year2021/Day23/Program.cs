using System.Collections.Generic;
using System.IO;
using System.Linq;
using Shared;

var solver = new Day23();
solver.PrintSolutions("input.txt");

public class Day23 : Solver
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