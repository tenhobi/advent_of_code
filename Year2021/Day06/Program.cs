using System;
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
        List<byte> data = File.ReadLines(inputFile).ToList()[0].Split(",").Select(byte.Parse).ToList();
        const byte daysToCompute = 80;
        const byte initialNewValue = 8;
        const byte oldNewValue = 6;

        for (var i = 0; i < daysToCompute; i++)
        {
            var count = data.Count;
            for (var j = 0; j < count; j++)
            {
                if (data[j] == 0)
                {
                    data.Add(initialNewValue);
                    data[j] = oldNewValue;
                    continue;
                }

                data[j]--;
            }
        }

        return data.Count.ToString();
    }

    public override string SolveSecond(string inputFile)
    {
        List<int> inData = File.ReadLines(inputFile).ToList()[0].Split(",").Select(int.Parse).ToList();
        const int daysToCompute = 256;
        const byte initialNewValue = 8;
        const byte oldNewValue = 6;

        var data = new long [9];
        inData.ForEach(i => data[i]++);

        for (var i = 0; i < daysToCompute; i++)
        {
            var addition = data[0];
            for (var daysLeft = 1; daysLeft < data.Length; daysLeft++)
            {
                data[daysLeft - 1] = data[daysLeft];
            }
            data[oldNewValue] += addition;
            data[initialNewValue] = addition;
        }

        return data.Sum().ToString();
    }
}