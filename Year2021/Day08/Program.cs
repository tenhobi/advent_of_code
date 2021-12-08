using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Shared;

var solver = new Day08();
solver.PrintSolutions("input.txt");

public class Day08 : Solver
{
    public override string SolveFirst(string inputFile)
    {
        var rightInput = File.ReadLines(inputFile).Select(line => line.Split("|")[1]).ToList();
        var specialLengths = new List<int>(new[] { 2, 3, 4, 7 });
        var sum = rightInput
            .SelectMany(line => line.Split(" ", StringSplitOptions.RemoveEmptyEntries))
            .Count(word => specialLengths.Contains(word.Length));

        return sum.ToString();
    }

    public override string SolveSecond(string inputFile)
    {
        var input = File.ReadLines(inputFile).Select(line => line.Split("|")[0]).ToList();
        var output = File.ReadLines(inputFile).Select(line => line.Split("|")[1]).ToList();

        var sum = 0;
        for (var index = 0; index < input.Count; index++)
        {
            var line = input[index];
            var mapping = new Dictionary<int, List<char>>(new[]
            {
                new KeyValuePair<int, List<char>>(0, new()),
                new KeyValuePair<int, List<char>>(1, new()),
                new KeyValuePair<int, List<char>>(2, new()),
                new KeyValuePair<int, List<char>>(3, new()),
                new KeyValuePair<int, List<char>>(4, new()),
                new KeyValuePair<int, List<char>>(5, new()),
                new KeyValuePair<int, List<char>>(6, new()),
                new KeyValuePair<int, List<char>>(7, new()),
                new KeyValuePair<int, List<char>>(8, new()),
                new KeyValuePair<int, List<char>>(9, new())
            });

            var unique = new[] { 2, 3, 4, 7 }.ToList();
            var words = line
                .Split(" ", StringSplitOptions.RemoveEmptyEntries)
                .OrderBy(s => s.Length)
                .ToList();
            foreach (var word in words.Where(s => unique.Contains(s.Length)))
            {
                switch (word.Length)
                {
                    case 2: // number 1
                        mapping[1] = new[] { word[0], word[1] }.ToList();
                        break;
                    case 3: // number 7
                        mapping[7] = new[] { word[0], word[1], word[2] }.ToList();
                        break;
                    case 4: // number 4
                        mapping[4] = new[] { word[0], word[1], word[2], word[3] }.ToList();
                        break;
                    case 7: // number 8
                        mapping[8] = new[] { word[0], word[1], word[2], word[3], word[4], word[5], word[6] }.ToList();
                        break;
                    default:
                        Console.WriteLine("huh?");
                        break;
                }
            }

            foreach (var word in words.Where(s => !unique.Contains(s.Length)))
            {
                switch (word.Length)
                {
                    case 5: // numbers 2, 3, 5
                        var thisWord = word.ToCharArray().ToList();
                        var intersectWithOne = thisWord.Intersect(mapping[1]).ToList();

                        // number 3
                        if (intersectWithOne.Count == 2)
                        {
                            mapping[3] = thisWord;
                            break;
                        }

                        var intersectWithFour = thisWord.Intersect(mapping[4]).ToList();

                        // number 5
                        if (intersectWithFour.Count == 3)
                        {
                            mapping[5] = thisWord;
                            break;
                        }

                        // number 2
                        mapping[2] = thisWord;
                        break;
                    case 6: // numbers 0, 6, 9
                        var thisWord2 = word.ToCharArray().ToList();
                        var intersectWithOne2 = thisWord2.Intersect(mapping[1]).ToList();

                        // number 6
                        if (intersectWithOne2.Count == 1)
                        {
                            mapping[6] = thisWord2;
                            break;
                        }

                        var intersectWithFour2 = thisWord2.Intersect(mapping[4]).ToList();

                        // number 9
                        if (intersectWithFour2.Count == 4)
                        {
                            mapping[9] = thisWord2;
                            break;
                        }

                        // number 0
                        mapping[0] = thisWord2;
                        break;
                    default:
                        Console.WriteLine("huh??");
                        break;
                }
            }

            var tmp = new StringBuilder();
            var outputWords = output[index].Split(" ", StringSplitOptions.RemoveEmptyEntries).ToList();
            foreach (var outputWord in outputWords)
            {
                foreach (var (key, value) in mapping)
                {
                    if (value.Count != outputWord.Length) continue;

                    var intersect = value.Intersect(outputWord.ToCharArray().ToList()).ToList();
                    if (intersect.Count ==
                        outputWord.Length)
                    {
                        tmp.Append(key);
                    }
                }
            }

            sum += int.Parse(tmp.ToString());
        }

        return sum.ToString();
    }
}