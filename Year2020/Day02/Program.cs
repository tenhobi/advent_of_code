using System.Collections.Generic;
using System.IO;
using System.Linq;
using Shared;

var solver = new Day02();
solver.PrintSolutions("input.txt");

public class Day02 : Solver
{
    public override string SolveFirst(string inputFile)
    {
        List<string> rules = File.ReadLines(inputFile).ToList();

        return rules.Aggregate(0, (acc, rule) =>
        {
            List<string> split = rule.Split(" ").ToList();
            var letter = split[1].First();
            var range = split[0].Split("-");
            var rangeLow = int.Parse(range[0]);
            var rangeHigh = int.Parse(range[1]);
            var text = split[2];

            var occurrences = text.Count(c => c == letter);

            if (rangeLow > occurrences || occurrences > rangeHigh) return acc;
            return acc + 1;
        }).ToString();
    }

    public override string SolveSecond(string inputFile)
    {
        List<string> rules = File.ReadLines(inputFile).ToList();

        return rules.Aggregate(0, (acc, rule) =>
        {
            List<string> split = rule.Split(" ").ToList();
            var letter = split[1].First();
            var range = split[0].Split("-");
            var rangeLow = int.Parse(range[0]);
            var rangeHigh = int.Parse(range[1]);
            var text = split[2];

            if (text[rangeLow - 1] == letter && text[rangeHigh - 1] != letter ||
                text[rangeLow - 1] != letter && text[rangeHigh - 1] == letter)
            {
                return acc + 1;
            }

            return acc;
        }).ToString();
    }
}
