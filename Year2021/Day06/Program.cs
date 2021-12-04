using System.Collections.Generic;
using System.IO;
using System.Linq;
using Shared;

var solver = new Day06();
solver.PrintSolutions("input.txt");

public class Day06 : Solver
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