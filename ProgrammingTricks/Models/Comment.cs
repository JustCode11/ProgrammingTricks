//------------------------------------------------------------------------------
// <auto-generated>
//     Der Code wurde von einer Vorlage generiert.
//
//     Manuelle Änderungen an dieser Datei führen möglicherweise zu unerwartetem Verhalten der Anwendung.
//     Manuelle Änderungen an dieser Datei werden überschrieben, wenn der Code neu generiert wird.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ProgrammingTricks.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Comment
    {
        public System.Guid CommentId { get; set; }
        public string CommentContent { get; set; }
        public Nullable<System.DateTime> CommentDate { get; set; }
        public Nullable<System.Guid> TricksId { get; set; }
        public string AuthorId { get; set; }
    
        public virtual Trick Trick { get; set; }
    }
}
