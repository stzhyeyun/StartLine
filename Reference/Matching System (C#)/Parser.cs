using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Text;

namespace MatchingSystem
{
    class Parser
    {
        public bool ParseScore(string input, out int score)
        {
            if (input.Contains<char>('-') || input == "0")
            {
                Console.WriteLine(
                    "\n Error : The values you entered ({0}) are invalid. Please try again.", input);

                score = 0;
                return false;
            }

            string figure = null;
            if (input.Contains<char>(',') || input.Contains<char>('.'))
            {
                char[] spliters = new char[2] { ',', '.' };
                string[] temp = input.Trim().Split(spliters);

                for (int i = 1; i < temp.Length; i++)
                {
                    if (temp[i].Length != 3)
                    {
                        Console.WriteLine(
                            "\n Error : The values you entered ({0}) are invalid. Please try again.", input);

                        score = 0;
                        return false;
                    }
                }

                for (int i = 0; i < temp.Length; i++)
                {
                    figure += temp[i];
                }
            }
            else
            {
                figure = input;
            }

            bool isParsed = Int32.TryParse(figure, out score);
            if (!isParsed)
            {
                Console.WriteLine(
                    "\n Error : The values you entered ({0}) are invalid. Please try again.", input);
            }            

            return isParsed;
        }

        public bool ParseData(out List<User> userList)
        {
            string filePath = Path.Combine(Environment.CurrentDirectory, "Data", "Data.txt");

            if (File.Exists(filePath))
            {
                List<User> tempList = new List<User>();

                try
                {
                    StreamReader reader = new StreamReader(filePath, Encoding.UTF8, true);
                    string[] texts = new string[5];
                    char[] comma = new char[1] { ',' };

                    while (!reader.EndOfStream)
                    {
                        texts = reader.ReadLine().Split(comma, 5);
                        User user = new User(
                            Int32.Parse(texts[0]),
                            texts[1],
                            Int32.Parse(texts[2]),
                            Int32.Parse(texts[3]),
                            Int32.Parse(texts[4]));
                        tempList.Add(user);
                    }
                    reader.Dispose();
                }
                catch
                {
                    Console.WriteLine("\n Error : User data is invalid.");

                    userList = null;
                    return false;
                }

                userList = tempList;
                return true;
            }
            else
            {
                Console.WriteLine("\n Error : User data does not exist. (Valid path : {0})", filePath);

                userList = null;
                return false;
            }
        }
    }
}