using System;

namespace Shared
{
    public abstract class Solver
    {
        public abstract string SolveFirst(string inputFile);
        public abstract string SolveSecond(string inputFile);

        public void PrintSolutions(string inputFile)
        {
            Console.WriteLine($"First task: {SolveFirst(inputFile)}");
            Console.WriteLine($"Second task: {SolveSecond(inputFile)}");
        }
    }
}