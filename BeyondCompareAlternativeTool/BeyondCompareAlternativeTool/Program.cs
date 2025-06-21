using BeyondCompareAlternativeTool.Comparer;
using BeyondCompareAlternativeTool.Models;
using BeyondCompareAlternativeTool.Utils;

namespace BeyondCompareAlternativeTool
{
    public class Program
    {
        static void Main(string[] args)
        {
            
            if (args.Length != 2)
            {
                Logger.Error("Please provide exactly 2 file paths.");
                return;
            }

            var comparator = new TextComparer();
            var report = comparator.Compare(args[0], args[1]);

            foreach (var diff in report.Differences)
            {
                //Console.WriteLine($"{diff.Type}: A[{diff.LineNumberA}] B[{diff.LineNumberB}]");
                //if (diff.LineContentA != null) Console.WriteLine($"  A: {diff.LineContentA}");
                //if (diff.LineContentB != null) Console.WriteLine($"  B: {diff.LineContentB}");

                Console.WriteLine($"[{diff.Type}]");

                string highlighted = TextComparer.GetWordLevelDiff(diff.LineContentA, diff.LineContentB, diff.Type);
                Console.WriteLine(highlighted);
                Console.WriteLine();

            }



        }

       
    }
}
