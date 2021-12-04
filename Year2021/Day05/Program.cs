using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using Shared;

var solver = new Day05();
solver.PrintSolutions("input.txt");

public class Day05 : Solver
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