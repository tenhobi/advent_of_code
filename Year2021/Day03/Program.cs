using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Shared;

var solver = new Day03();
solver.PrintSolutions("input.txt");

public class Day03 : Solver
{
    public override string SolveFirst(string inputFile)
    {
        List<string> data = File.ReadLines(inputFile).ToList();
        var width = data[0].Length;
        var height = data.Count;

        List<char> gamaRateBinList = new();

        for (var i = 0; i < width; i++)
        {
            var ones = data.Count(line => line[i] == '1');
            gamaRateBinList.Add(ones >= height / 2 ? '1' : '0');
        }

        string gamaBinary = new(gamaRateBinList.ToArray());
        var gama = Convert.ToInt32(gamaBinary, 2);
        string epsilonBinary = new(gamaBinary.Select(c => c == '1' ? '0' : '1').ToArray());
        var epsilon = Convert.ToInt32(epsilonBinary, 2);

        return (gama * epsilon).ToString();
    }

    public override string SolveSecond(string inputFile)
    {
        List<string> data = File.ReadLines(inputFile).ToList();
        var width = data[0].Length;

        // oxygen generator rating
        var oxygenData = data;
        for (var i = 0; i < width; i++)
        {
            if (oxygenData.Count == 1)
            {
                break;
            }

            var ones = oxygenData.Count(line => line[i] == '1');
            var zeros = oxygenData.Count - ones;
            oxygenData = oxygenData.FindAll(s => ones >= zeros ? s[i] == '1' : s[i] == '0');
        }

        // CO2 scrubber rating
        var co2Data = data;
        for (var i = 0; i < width; i++)
        {
            if (co2Data.Count == 1)
            {
                break;
            }

            var ones = co2Data.Count(line => line[i] == '1');
            var zeros = co2Data.Count - ones;
            co2Data = co2Data.FindAll(s => ones >= zeros ? s[i] == '0' : s[i] == '1');
        }

        string oxygenBinary = new(oxygenData[0].ToArray());
        var oxygen = Convert.ToInt32(oxygenBinary, 2);

        string co2Binary = new(co2Data[0].ToArray());
        var co2 = Convert.ToInt32(co2Binary, 2);

        return (oxygen * co2).ToString();
    }
}
