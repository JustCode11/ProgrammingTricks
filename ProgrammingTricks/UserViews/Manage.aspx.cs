using Microsoft.AspNet.Identity;
using ProgrammingTricks.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProgrammingTricks.UserViews
{
    public partial class Manage : System.Web.UI.Page
    {
        ProgrammierTricksEntities db = new ProgrammierTricksEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["PasswordChanged"] != null)
                {
                    lblPasswordChangedInfo.Text = "Das Passwort wurde erfolgreich geändert";
                    Session["PasswordChanged"] = null;
                }
                
                string userId = User.Identity.GetUserId();
                AspNetUser user = (from i in db.AspNetUsers
                                  where i.Id == userId
                                  select i).First();


                string userName = User.Identity.GetUserName();
                string userEmail = user.Email;

                lblUserName.Text = userName;
                lblEmail.Text = userEmail;

                var comments = (from c in db.Comments
                                where c.AuthorId == userId
                                select c).ToList();
                int numComments = comments.Count;
                var entries = (from t in db.Tricks
                               where t.AuthorId == userId
                               select t).ToList();
                int numEntries = entries.Count;

                lblCreatedComments.Text = numComments.ToString();
                lblCreatedEntries.Text = numEntries.ToString();
            }
        }

        // Der Rückgabetyp kann in 'IEnumerable' geändert werden. Damit Paginierung und Sortierung für
        // unterstützt werden, müssen jedoch die folgenden Parameter hinzugefügt werden:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<ProgrammingTricks.Models.TricksGridViewModel> gvUserEntries_GetData()
        {
            string userId = User.Identity.GetUserId();
            return from t in db.Tricks
                   join l in db.ProgrammingLanguages
                   on t.Language equals l.LanguageId
                   orderby t.UploadDate
                   where t.AuthorId == userId
                   select new TricksGridViewModel
                   {
                       TricksId = t.TricksId,
                       UploadDate = t.UploadDate,
                       Title = t.Title,
                       Description = t.Description,
                       Language = l.LanguageName
                   };
        }
    }
}