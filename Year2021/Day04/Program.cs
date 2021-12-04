using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using Shared;

var solver = new Day04();
solver.PrintSolutions("input.txt");

public class Day04 : Solver
{
    public class Board
    {
        private int[,] numbers = new int[5, 5];
        private List<int> picks = new();

        public void AddPick(int pick)
        {
            picks.Add(pick);
        }

        public (bool, int) IsWinning()
        {
            var win = false;
            var winIndex = 0;
            var winSum = 0;
            
            // check rows ----
            for (var row = 0; row < 5; row++)
            {
                var count = 0;
                for (var column = 0; column < 5; column++)
                {
                    count += picks.Count(pick => numbers[row, column] == pick);
                }

                if (count != 5) continue;

                win = true;
                winIndex = row;
                break;
            }

            if (win)
            {
                for (int row = 0; row < 5; row++)
                {
                    if (row != winIndex)
                    {
                        for (var column = 0; column < 5; column++)
                        {
                            if (!picks.Contains(numbers[row, column]))
                            {
                                winSum += numbers[row, column];
                            }
                        }
                    }
                }

                return (win, winSum * picks.Last());
            }
            
            // check columns |
            for (var column = 0; column < 5; column++)
            {
                var count = 0;
                for (var row = 0; row < 5; row++)
                {
                    count += picks.Count(pick => numbers[row, column] == pick);
                }

                if (count != 5) continue;

                win = true;
                winIndex = column;
                break;
            }

            if (win)
            {
                for (int column = 0; column < 5; column++)
                {
                    if (column != winIndex)
                    {
                        for (var row = 0; row < 5; row++)
                        {
                            if (!picks.Contains(numbers[row, column]))
                            {
                                winSum += numbers[row, column];
                            }
                        }
                    }
                }

                return (win, winSum * picks.Last());
            }

            return (win, 0);
        }

        public void AddRow(int row, List<int> rowNumbers)
        {
            for (var i = 0; i < rowNumbers.Count; i++)
            {
                numbers[row, i] = rowNumbers[i];
            }
        }
    }

    public override string SolveFirst(string inputFile)
    {
        List<string> data = File.ReadLines(inputFile).ToList();
        var picks = data[0].Split(",").Select(int.Parse).ToList();

        data = data.Skip(1).ToList();

        var numberOfBoards = data.Count / 6;
        List<Board> boards = new();
        for (var i = 0; i < numberOfBoards; i++)
        {
            boards.Add(new Board());
            boards[i].AddRow(0,
                data[i * 6 + 1].Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList());
            boards[i].AddRow(1,
                data[i * 6 + 2].Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList());
            boards[i].AddRow(2,
                data[i * 6 + 3].Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList());
            boards[i].AddRow(3,
                data[i * 6 + 4].Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList());
            boards[i].AddRow(4,
                data[i * 6 + 5].Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList());
        }

        foreach (var pick in picks)
        {
            foreach (var board in boards)
            {
                board.AddPick(pick);
                var winData = board.IsWinning(); 
                if (!winData.Item1) continue;

                return winData.Item2.ToString();
            }
        }

        return "?";
    }

    public override string SolveSecond(string inputFile)
    {
        List<string> data = File.ReadLines(inputFile).ToList();
        var picks = data[0].Split(",").Select(int.Parse).ToList();

        data = data.Skip(1).ToList();

        var numberOfBoards = data.Count / 6;
        List<Board> boards = new();
        for (var i = 0; i < numberOfBoards; i++)
        {
            boards.Add(new Board());
            boards[i].AddRow(0,
                data[i * 6 + 1].Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList());
            boards[i].AddRow(1,
                data[i * 6 + 2].Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList());
            boards[i].AddRow(2,
                data[i * 6 + 3].Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList());
            boards[i].AddRow(3,
                data[i * 6 + 4].Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList());
            boards[i].AddRow(4,
                data[i * 6 + 5].Split(' ', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList());
        }

        List<(int, int)> boardsThatWon = new();
        foreach (var pick in picks)
        {
            for (var i = 0; i < boards.Count; i++)
            {
                var board = boards[i];
                board.AddPick(pick);
                var winData = board.IsWinning();
                if (!winData.Item1) continue;

                if (!boardsThatWon.Select(tuple => tuple.Item1).Contains(i))
                {
                    boardsThatWon.Add((i, winData.Item2));
                }
            }
        }
        
        return boardsThatWon.Count != 0 ? boardsThatWon.Last().Item2.ToString() : "?";
    }
}