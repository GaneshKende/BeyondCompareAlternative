using BeyondCompareAlternativeTool.Models;
using BeyondCompareAlternativeTool.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BeyondCompareAlternativeTool.Comparer
{
    public class TextComparer
    {
        private static string ColorRed(string text) => $"\u001b[31m{text}\u001b[0m";     // Red: Removed
        private static string ColorGreen(string text) => $"\u001b[32m{text}\u001b[0m";   // Green: Added
        private static string ColorYellow(string text) => $"\u001b[33m{text}\u001b[0m";  // Yellow: Unchanged

        public DiffReport Compare(string filePathA, string filePathB)
        {
            Logger.Info($"Starting comparison between {filePathA} and {filePathB}");

            var linesA = File.ReadAllLines(filePathA);
            var linesB = File.ReadAllLines(filePathB);

            var report = new DiffReport
            {
                FileA = Path.GetFileName(filePathA),
                FileB = Path.GetFileName(filePathB)
            };

            var script = ComputeDiff(linesA, linesB);

            foreach (var step in script)
                report.Differences.Add(step);

            Logger.Info("Comparison complete");
            return report;
        }

        private List<DiffItem> Backtrack(List<Dictionary<int, int>> trace, string[] a, string[] b)
        {
            var diffs = new List<DiffItem>();
            int x = a.Length, y = b.Length;

            for (int d = trace.Count - 1; d >= 0; d--)
            {
                var V = trace[d];
                int k = x - y;

                int xDown = GetSafe(V, k + 1);
                int xLeft = GetSafe(V, k - 1) + 1;

                int prevK = (k == -d || (k != d && xLeft < xDown)) ? k + 1 : k - 1;
                int prevX = GetSafe(V, prevK);
                int prevY = prevX - prevK;

                while (x > prevX && y > prevY)
                {
                    x--; y--;
                    diffs.Insert(0, new DiffItem
                    {
                        LineNumberA = x + 1,
                        LineNumberB = y + 1,
                        LineContentA = a[x],
                        LineContentB = b[y],
                        Type = DiffType.Unchanged
                    });
                }

                if (x == prevX)
                {
                    y--;
                    if (y >= 0)
                    {
                        diffs.Insert(0, new DiffItem
                        {
                            LineNumberA = 0,
                            LineNumberB = y + 1,
                            LineContentA = null,
                            LineContentB = b[y],
                            Type = DiffType.Added
                        });
                    }
                }
                else
                {
                    x--;
                    if (x >= 0)
                    {
                        diffs.Insert(0, new DiffItem
                        {
                            LineNumberA = x + 1,
                            LineNumberB = 0,
                            LineContentA = a[x],
                            LineContentB = null,
                            Type = DiffType.Removed
                        });
                    }
                }

            }

            return diffs;
        }


        private List<DiffItem> ComputeDiff(string[] a, string[] b)
        {
            int N = a.Length, M = b.Length;
            int MAX = N + M;
            var V = new Dictionary<int, int> { [1] = 0 };
            var trace = new List<Dictionary<int, int>>();

            for (int d = 0; d <= MAX; d++)
            {
                var current = new Dictionary<int, int>();

                for (int k = -d; k <= d; k += 2)
                {
                    int x;
                    int xDown = GetSafe(V, k + 1);
                    int xLeft = GetSafe(V, k - 1) + 1;

                    if (k == -d || (k != d && xLeft < xDown))
                        x = xDown;
                    else
                        x = xLeft;

                    int y = x - k;

                    while (x < N && y < M && a[x] == b[y])
                    {
                        x++;
                        y++;
                    }

                    current[k] = x;

                    if (x >= N && y >= M)
                    {
                        trace.Add(current);
                        return Backtrack(trace, a, b);
                    }
                }

                trace.Add(current);
                V = current;
            }

            return new List<DiffItem>();
        }

        private int GetSafe(Dictionary<int, int> dict, int key, int fallback = 0)
        {
            return dict.TryGetValue(key, out int value) ? value : fallback;
        }


        public static string GetWordLevelDiff(string? lineA, string? lineB, DiffType type)
        {
            if (lineA == null && lineB == null) return "";

            var wordsA = lineA?.Split(' ', StringSplitOptions.RemoveEmptyEntries) ?? Array.Empty<string>();
            var wordsB = lineB?.Split(' ', StringSplitOptions.RemoveEmptyEntries) ?? Array.Empty<string>();

            var result = new List<string>();

            int i = 0, j = 0;

            while (i < wordsA.Length && j < wordsB.Length)
            {
                if (wordsA[i] == wordsB[j])
                {
                    result.Add(ColorYellow(wordsA[i]));
                    i++; j++;
                }
                else
                {
                    result.Add(ColorRed(wordsA[i]));
                    result.Add(ColorGreen(wordsB[j]));
                    i++; j++;
                }
            }

            while (i < wordsA.Length)
            {
                result.Add(ColorRed(wordsA[i]));
                i++;
            }

            while (j < wordsB.Length)
            {
                result.Add(ColorGreen(wordsB[j]));
                j++;
            }

            return string.Join(' ', result);
        }

    }
}
