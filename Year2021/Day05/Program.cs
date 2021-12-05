using System.Collections.Generic;
using System.IO;
using System.Linq;
using Shared;

var solver = new Day05();
solver.PrintSolutions("input.txt");

public class Day05 : Solver
{
    private record Data(int X1, int Y1, int X2, int Y2);

    public override string SolveFirst(string inputFile)
    {
        List<Data> data = File.ReadLines(inputFile).Select(s =>
        {
            var tmp = s.Split(" -> ");
            var begin = tmp[0].Split(",");
            var end = tmp[1].Split(",");
            return new Data(int.Parse(begin[0]), int.Parse(begin[1]), int.Parse(end[0]), int.Parse(end[1]));
        }).ToList();

        var size = data.Select(d => new [] {d.X1, d.X2, d.Y1, d.Y2}.Max()).Max() + 1;
        int[,] area = new int[size, size];

        foreach (var line in data)
        {
            // horizontal
            if (line.X1 == line.X2)
            {
                var lesserY = line.Y1 < line.Y2 ? line.Y1 : line.Y2;
                var biggerY = line.Y1 > line.Y2 ? line.Y1 : line.Y2;
                for (var i = lesserY; i <= biggerY; i++)
                {
                    area[i, line.X1]++;
                }
            }
            // vertical
            else if (line.Y1 == line.Y2)
            {
                var lesserX = line.X1 < line.X2 ? line.X1 : line.X2;
                var biggerX = line.X1 > line.X2 ? line.X1 : line.X2;
                for (int i = lesserX; i <= biggerX; i++)
                {
                    area[line.Y1, i]++;
                }
            }
        }

        var counter = 0;
        for (var y = 0; y < size; y++)
        {
            for (var x = 0; x < size; x++)
            {
                if (area[y, x] > 1) counter++;
            }
        }

        return counter.ToString();
    }

    public override string SolveSecond(string inputFile)
    {
        List<Data> data = File.ReadLines(inputFile).Select(s =>
        {
            var tmp = s.Split(" -> ");
            var begin = tmp[0].Split(",");
            var end = tmp[1].Split(",");
            return new Data(int.Parse(begin[0]), int.Parse(begin[1]), int.Parse(end[0]), int.Parse(end[1]));
        }).ToList();

        var size = data.Select(d => new[] { d.X1, d.X2, d.Y1, d.Y2 }.Max()).Max() + 1;
        int[,] area = new int[size, size];

        foreach (var line in data)
        {
            // horizontal
            if (line.X1 == line.X2)
            {
                var lesserY = line.Y1 < line.Y2 ? line.Y1 : line.Y2;
                var biggerY = line.Y1 > line.Y2 ? line.Y1 : line.Y2;
                for (var i = lesserY; i <= biggerY; i++)
                {
                    area[i, line.X1]++;
                }
            }
            // vertical
            else if (line.Y1 == line.Y2)
            {
                var lesserX = line.X1 < line.X2 ? line.X1 : line.X2;
                var biggerX = line.X1 > line.X2 ? line.X1 : line.X2;
                for (var i = lesserX; i <= biggerX; i++)
                {
                    area[line.Y1, i]++;
                }
            }
            // diagonal
            else
            {
                // left to right
                if (line.X1 < line.X2)
                {
                    if (line.Y1 < line.Y2)
                    {
                        for (var i = line.Y1; i <= line.Y2; i++)
                        {
                            area[i, line.X1 + (i - line.Y1)]++;
                        }
                    }
                    else
                    {
                        for (var i = line.Y2; i <= line.Y1; i++)
                        {
                            area[i, line.X2 - (i - line.Y2)]++;
                        }
                    }
                }
                // right to left
                else
                {
                    if (line.Y1 < line.Y2)
                    {
                        for (var i = line.Y1; i <= line.Y2; i++)
                        {
                            area[i, line.X1 - (i - line.Y1)]++;
                        }
                    }
                    else
                    {
                        for (var i = line.Y2; i <= line.Y1; i++)
                        {
                            area[i, line.X2 + (i - line.Y2)]++;
                        }
                    }
                }
            }
        }

        var counter = 0;
        for (var y = 0; y < size; y++)
        {
            for (int x = 0; x < size; x++)
            {
                if (area[y, x] > 1) counter++;
            }
        }

        return counter.ToString();
    }
}
