using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BeyondCompareAlternativeTool.Models
{
    public enum DiffType { Unchanged, Added, Removed }

    public class DiffItem
    {
        public int LineNumberA { get; set; }
        public int LineNumberB { get; set; }
        public string LineContentA { get; set; }
        public string LineContentB { get; set; }
        public DiffType Type { get; set; }
    }
    public class DiffReport
    {
        public List<DiffItem> Differences { get; set; } = new List<DiffItem>();
        public string FileA { get; set; }
        public string FileB { get; set; }
    }
}
