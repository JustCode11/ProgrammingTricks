using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProgrammingTricks.Models
{
    public class DetailsViewCommentModel
    {
        public Guid CommentId { get; set; }
        public string UserName { get; set; }
        public DateTime CommentDate { get; set; }
        public string CommentContent { get; set; }
    }
}