using System;

namespace Shared
{
    public interface ISolver
    {
        string SolveFirst(string inputFile);

        string SolveSecond(string inputFile);

        void PrintSolutions(string inputFile)
        {
            Console.WriteLine($"First task: {SolveFirst(inputFile)}");
            Console.WriteLine($"Second task: {SolveSecond(inputFile)}");
        }
    }
}
