using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ProgrammingTricks.Models;
using System.Web.ModelBinding;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System.Data.Entity;
using System.Data.Entity.Validation;

namespace ProgrammingTricks
{
    public partial class Default : System.Web.UI.Page
    {
        ProgrammierTricksEntities db = new ProgrammierTricksEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Trick trick = (from t in db.Tricks
                               select t).FirstOrDefault();
                if (trick.TricksId != null)
                {
                    ViewState["trickId"] = trick.TricksId;
                }
            }
        }

        protected void gvTricks_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = gvTricks.SelectedRow.RowIndex;
            Guid trickId = Guid.Parse(gvTricks.DataKeys[index].Values[0].ToString());
            ViewState["trickId"] = trickId;
        }

        public IQueryable<TricksGridViewModel> gvTricks_GetData()
        {
            return from t in db.Tricks
                   join l in db.ProgrammingLanguages
                   on t.Language equals l.LanguageId
                   orderby t.UploadDate
                   select new TricksGridViewModel
                   {
                       TricksId = t.TricksId,
                       UploadDate = t.UploadDate,
                       Title = t.Title,
                       Description = t.Description,
                       Language = l.LanguageName
                   };
        }

        protected void btnSendComment_Click(object sender, EventArgs e)
        {
            bool isAuthenticated = (System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated;
            Label warning = (Label)dvTricks.FindControl("lblCommentWarning");
            if (isAuthenticated)
            {
                if (IsValid)
                {
                    int index = gvTricks.SelectedRow.RowIndex;
                    Guid trickId = Guid.Parse(gvTricks.DataKeys[index].Values[0].ToString());
                    TextBox commentTextBox = (TextBox)dvTricks.FindControl("txtComment");
                    string commentContent = commentTextBox.Text;
                    string userId = User.Identity.GetUserId();
                    var comment = new Comment();
                    comment.CommentId = Guid.NewGuid();
                    comment.CommentContent = commentContent;
                    comment.AuthorId = userId;
                    comment.CommentDate = DateTime.Now;
                    comment.TricksId = trickId;

                    db.Comments.Add(comment);
                    try
                    {
                        db.SaveChanges();
                    }
                    catch (DbEntityValidationException ex)
                    {
                        warning.Text = ex.Message;
                    }
                    catch (Exception ex)
                    {
                        warning.Text = ex.Message;
                    }
                }
            }
            else
            {
                warning.Text = "Sie müssen sich vorher anmelden um zu kommentieren.";
            }
        }

        protected void btnAddComment_Click(object sender, EventArgs e)
        {
            ListView lvComment = (ListView)dvTricks.FindControl("lvComments");
            lvComment.InsertItemPosition = InsertItemPosition.FirstItem;
        }

        protected void lvComments_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "insert":
                    {
                        bool isAuthenticated = (System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated;
                        Label warning = (Label)e.Item.FindControl("lblCommentWarning");
                        if (isAuthenticated)
                        {
                            if (IsValid)
                            {
                                Guid trickId = (Guid)ViewState["trickId"];
                                TextBox commentTextBox = (TextBox)e.Item.FindControl("txtComment");
                                string commentContent = commentTextBox.Text;
                                string userId = User.Identity.GetUserId();
                                var comment = new Comment();
                                comment.CommentId = Guid.NewGuid();
                                comment.CommentContent = commentContent;
                                comment.AuthorId = userId;
                                comment.CommentDate = DateTime.Now;
                                comment.TricksId = trickId;

                                db.Comments.Add(comment);
                                try
                                {
                                    db.SaveChanges();
                                }
                                catch (DbEntityValidationException ex)
                                {
                                    warning.Text = ex.Message;
                                }
                                catch (Exception ex)
                                {
                                    warning.Text = ex.Message;
                                }
                            }
                        }
                        else
                        {
                            warning.Text = "Sie müssen sich vorher anmelden um zu kommentieren.";
                        }
                        break;
                    }
                default:
                    break;
            }
        }

        public object dvTricks_GetItem([ViewState("trickId")] Guid trickId)
        {
            if (ViewState["trickId"] != null)
            {
                //trickId = (Guid)ViewState["trickId"];
                return from t in db.Tricks
                       join l in db.ProgrammingLanguages
                       on t.Language equals l.LanguageId
                       join u in db.AspNetUsers
                       on t.AuthorId equals u.Id
                       where t.TricksId == trickId
                       select new
                       {
                           t.TricksId,
                           t.UploadDate,
                           t.Title,
                           t.Description,
                           t.TrickContent,
                           Language = l.LanguageName,
                           UserName = u.UserName
                       };
            }
            return null;
        }

        public IQueryable<DetailsViewCommentModel> lvComments_GetData()
        {
            Guid trickId = (Guid)ViewState["trickId"];
            return from c in db.Comments
                   join u in db.AspNetUsers
                   on c.AuthorId equals u.Id
                   where c.TricksId == trickId
                   orderby c.CommentDate descending
                   select new DetailsViewCommentModel
                   {
                       CommentId = c.CommentId,
                       CommentDate = (DateTime)c.CommentDate,
                       CommentContent = c.CommentContent,
                       UserName = u.UserName
                   }; ;
        }

        public void lvComments_InsertItem()
        {
            bool isAuthenticated = (System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated;
            Label warning = lblCommentWarning;
            if (isAuthenticated)
            {
                if (IsValid)
                {
                    Guid trickId = (Guid)ViewState["trickId"];
                    //TextBox commentTextBox = (TextBox)ViewState["commentContent"];
                    string commentContent = (string)ViewState["commentContent"];
                    string userId = User.Identity.GetUserId();
                    var comment = new Comment();
                    comment.CommentId = Guid.NewGuid();
                    comment.CommentContent = commentContent;
                    comment.AuthorId = userId;
                    comment.CommentDate = DateTime.Now;
                    comment.TricksId = trickId;

                    db.Comments.Add(comment);
                    try
                    {
                        db.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        warning.Text = ex.Message;
                    }
                }
            }
            else
            {
                warning.Text = "Sie müssen sich vorher anmelden um zu kommentieren.";
            }
        }

        protected void lvComments_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            TextBox commentTextBox = (TextBox)e.Item.FindControl("txtComment");
            string commentContent = commentTextBox.Text;
            ViewState["commentContent"] = commentContent;
        }

        protected void lvComments_DataBound(object sender, EventArgs e)
        {
            ListView listView = (ListView)dvTricks.FindControl("lvComments");
            Label label = (Label)listView.FindControl("lblNumComments");
            Guid trickId = (Guid)ViewState["trickId"];
            var listOfComments = (from c in db.Comments
                                  join u in db.AspNetUsers
                                  on c.AuthorId equals u.Id
                                  where c.TricksId == trickId
                                  orderby c.CommentDate descending
                                  select new
                                  {
                                      c.CommentId,
                                      c.CommentDate,
                                      c.CommentContent,
                                      UserName = u.UserName
                                  }).ToList();
            int num = listOfComments.Count;
            if (num != 0)
            {
                label.Text = num.ToString();
            }
        }

        protected void lvComments_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            Guid trickId = (Guid)ViewState["trickId"];
            Trick trick = (from t in db.Tricks
                           where t.TricksId == trickId
                           select t).First();
            string authorId = trick.AuthorId;

            Label label = (Label)e.Item.FindControl("lblIsAuthor");
            var hyphen = e.Item.FindControl("hyphen");

            ListView listView = (ListView)dvTricks.FindControl("lvComments");
            Guid commentId = Guid.Parse(listView.DataKeys[e.Item.DisplayIndex].Value.ToString());

            Comment comment = (from c in db.Comments
                               where c.CommentId == commentId
                               select c).First();

            if (comment.AuthorId == authorId)
            {
                hyphen.Visible = true;
                label.Text = "Ersteller";
            }
        }
    }
}