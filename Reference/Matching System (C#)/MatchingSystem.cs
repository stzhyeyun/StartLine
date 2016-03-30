using System;
using System.Collections.Generic;
using System.Linq;

namespace MatchingSystem
{
    class MatchingSystem
    {
        const int _numRequired = 5;
        SortedList<int, Group> _userData = new SortedList<int, Group>(); // Key : Group ID, Value : Group
        
        public bool Initialize()
        {
            Parser parser = new Parser();
            List<User> rawData = new List<User>();

            if (parser.ParseData(out rawData))
            {
                GroupByScore(rawData);
                return true;
            }
            else
            {
                return false;
            }            
        }

        public void MatchByScore(int myScore)
        {
            int myGroupId = DetermineWhichGroup(myScore);

            // Find valid target
            int targetId = myGroupId;
            bool isCheckedGroup11 = false;
            
            while (!_userData.ContainsKey(targetId))
            {
                if (targetId == 11)
                {
                    isCheckedGroup11 = true;
                }
                else if (targetId == 1)
                {
                    Console.WriteLine("\n Error : User data does not exist.");
                    return;
                }

                if (isCheckedGroup11)
                {
                    targetId--;
                }
                else
                {
                    targetId++;
                }
            }

            // Start matching
            List<Group> matchedGroup = new List<Group>();
            int numRequired = _numRequired;
            int upperIndex = -1, lowerIndex = -1;

            // My group
            if (targetId == myGroupId)
            {
                matchedGroup.Add(new Group(
                    targetId,
                    _userData[targetId].GetNear(myScore, numRequired, out numRequired)));

                upperIndex = _userData.IndexOfKey(targetId) + 1;
                lowerIndex = _userData.IndexOfKey(targetId) - 1;
            }
            else if (targetId > myGroupId)
            {
                upperIndex = _userData.IndexOfKey(targetId);
                lowerIndex = _userData.IndexOfKey(myGroupId - 1);
            }
            else if (targetId < myGroupId)
            {
                lowerIndex = _userData.IndexOfKey(targetId);
            }

            // Upper & Lower group
            Group intermediateGroup = new Group(0);
            if (numRequired != 0)
            {
                int requiredOfUpper = numRequired;
                int requiredOfLower = numRequired;

                while (requiredOfUpper != 0)
                {
                    if (upperIndex == -1 || upperIndex >= _userData.Count)
                        break;

                    intermediateGroup.AddUser(
                        _userData.Values[upperIndex].GetBottom(requiredOfUpper, out requiredOfUpper));

                    upperIndex++;
                }

                while (requiredOfLower != 0)
                {
                    if (lowerIndex < 0)
                        break;

                    intermediateGroup.AddUser(
                        _userData.Values[lowerIndex].GetTop(requiredOfLower, out requiredOfLower));

                    lowerIndex--;
                }
            }

            // Set results
            List<Group> temp = new List<Group>();
            GroupByScore(
                intermediateGroup.GetNear(myScore, numRequired, out numRequired),
                out temp);

            for (int i = 0; i < temp.Count; i++)
            {
                matchedGroup.Add(temp[i]);
            }

            // Print results
            PrintResult(myGroupId, matchedGroup);
        }

        void GroupByScore(List<User> rawData)
        {
            // Group Users by Score
            for (int i = 0; i < rawData.Count; i++)
            {
                AddUser(
                    DetermineWhichGroup(rawData[i].GetScore()),
                    rawData[i]);
            }

            // Users in Group -> Order by Score ascending
            foreach (Group group in _userData.Values)
            {
                group.Sort();
            }            
        }

        void GroupByScore(List<User> rawData, out List<Group> result)
        {
            int groupId = 0;
            bool doesExist = false;
            List<Group> temp = new List<Group>();

            for (int i = 0; i < rawData.Count; i++)
            {
                groupId = DetermineWhichGroup(rawData[i].GetScore());

                for (int j = 0; j < temp.Count; j++)
                {
                    if (temp[j].Id == groupId)
                    {
                        temp[j].AddUser(rawData[i]);
                        doesExist = true;
                        break;
                    }
                }

                if (!doesExist)
                {
                    Group group = new Group(groupId);
                    group.AddUser(rawData[i]);
                    temp.Add(group);
                }
                doesExist = false;                
            }

            temp.Sort(new IdComparerForDescendingSort());
            result = temp;
        }

        int DetermineWhichGroup(int score) // Return Group ID
        {
            return Math.Min((int)Math.Ceiling(score / 100000f), 11);
        }

        void AddUser(int groupId, User newOne)
        {
            if (newOne != null)
            {
                if (!_userData.ContainsKey(groupId))
                {
                    Group group = new Group(groupId);
                    group.AddUser(newOne);
                    _userData.Add(groupId, group);
                }
                else
                {
                    _userData[groupId].AddUser(newOne);
                }                
            }
        }

        void PrintResult(int myGroupId, List<Group> result)
        {
            Console.WriteLine("\n======================================================================");
            Console.WriteLine("\n [Result]");
            Console.WriteLine("\n Your group : {0}", myGroupId);

            for (int i = 0; i < result.Count; i++)
            {
                result[i].Print();
            }

            Console.WriteLine("\n======================================================================");
        }
    }

    class Group
    {
        List<User> _member = new List<User>();

        public int Id { get; }

        public Group(int id)
        {
            Id = id;
        }

        public Group(int id, List<User> member)
        {
            Id = id;
            _member = member;
        }

        public List<User> GetNear(int score, int numRequired, out int numRemaining)
        {
            // Set Diff
            for (int i = 0; i < _member.Count; i++)
            {
                _member[i].Diff = Math.Abs(score - _member[i].GetScore());
            }

            // Sort by Diff
            _member.Sort(new DiffComparerForAscendingSort());

            // Pick results out
            List<User> result = new List<User>();
            for (int i = 0; i < _member.Count; i++)
            {
                if (i == numRequired)
                    break;

                result.Add(_member[i]);
            }

            // Sort by Score (Reset)
            _member.Sort(new ScoreComparerForAscendingSort());

            numRemaining = numRequired - result.Count();
            return result;
        }

        public List<User> GetTop(int numRequired, out int numRemaining)
        {
            List<User> result = new List<User>();

            for (int i = 0; i < _member.Count; i++)
            {
                if (i == numRequired)
                    break;

                result.Add(_member[i]);
            }

            numRemaining = numRequired - result.Count();
            return result;
        }

        public List<User> GetBottom(int numRequired, out int numRemaining)
        {
            List<User> result = new List<User>();

            int j = 0;
            for (int i = _member.Count - 1; i >= 0; i--)
            {
                if (j == numRequired)
                    break;

                result.Add(_member[i]);
                j++;
            }

            numRemaining = numRequired - result.Count;
            return result;
        }

        public void AddUser(User newOne)
        {
            if (newOne != null)
            {
                _member.Add(newOne);
            }
        }

        public void AddUser(List<User> newOne)
        {
            if (newOne != null)
            {
                _member.AddRange(newOne);
            }
        }

        public int Count()
        {
            return _member.Count;
        }

        public void Sort()
        {
            _member.Sort(new ScoreComparerForAscendingSort());
        }

        public void Print()
        {
            Console.WriteLine(
                "\n > Matched group : {0} ({1} players)", Id, _member.Count);

            for (int i = 0; i < _member.Count; i++)
            {
                Console.Write("  - User {0}", i + 1);
                _member[i].Print();
            }
        }       
    }

    class User
    {
        int _id = -1;
        string _name = null;
        int _score = 0;
        int _numWin = 0;
        int _numDefeat = 0;
                
        public int Diff { get; set; }

        public User(int id, string name, int score, int numWin, int numDefeat)
        {
            _id = id;
            _name = name;
            _score = score;
            _numWin = numWin;
            _numDefeat = numDefeat;
        }

        public int GetScore()
        {
            return _score;
        }

        public void Print()
        {
            Console.WriteLine(
                " (ID : {0}, Name : {1}, Score : {2}, Win : {3}, Defeat : {4})",
                _id, _name, _score, _numWin, _numDefeat);
        }
    }

    class IdComparerForDescendingSort : IComparer<Group>
    {
        public int Compare(Group x, Group y)
        {
            if (x.Id < y.Id)
            {
                return 1;
            }
            else if (x.Id > y.Id)
            {
                return -1;
            }
            else
            {
                return 0;
            }
        }
    }

    class ScoreComparerForAscendingSort : IComparer<User>
    {
        public int Compare(User x, User y)
        {
            int scoreX = x.GetScore();
            int scoreY = y.GetScore();
            
            if (scoreX < scoreY)
            {
                return -1;
            }
            else if (scoreX > scoreY)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
    }

    class DiffComparerForAscendingSort : IComparer<User>
    {
        public int Compare(User x, User y)
        {
            if (x.Diff < y.Diff)
            {
                return -1;
            }
            else if (x.Diff > y.Diff)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
    }
}
