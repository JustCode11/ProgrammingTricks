using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProgrammingTricks.Models
{
    public class TricksGridViewModel
    {
        public Guid TricksId { get; set; }
        public DateTime UploadDate { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Language { get; set; }
    }
}