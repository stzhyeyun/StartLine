using System;

namespace MatchingSystem
{
    class Program
    {
        static Parser scoreParser = new Parser();

        static void Main(string[] args)
        {
            Console.WriteLine("\n <Player Matching System by Score>");
            Console.WriteLine("\n Notice : Press ESC key to quit.");

            MatchingSystem system = new MatchingSystem();
            if (!system.Initialize())
            {
                TerminateProgram();
            }

            int myScore;
            while (true)
            {
                if (InputScore(out myScore))
                {
                    system.MatchByScore(myScore);
                }

                if (Console.ReadKey(true).Key == ConsoleKey.Escape)
                {
                    TerminateProgram();
                }
            }
        }

        static bool InputScore(out int score)
        {
            Console.Write("\n Input your score : ");
            string input = Console.ReadLine();

            return scoreParser.ParseScore(input, out score);
        }

        static void TerminateProgram()
        {
            Console.WriteLine("\n Notice : The program will be terminated. Press any key...");
            Console.ReadKey();
            Environment.Exit(0);            
        }
    }   
}
