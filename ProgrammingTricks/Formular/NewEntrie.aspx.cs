using Microsoft.AspNet.Identity;
using ProgrammingTricks.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProgrammingTricks.Formular
{
    public partial class NewEntrie : System.Web.UI.Page
    {
        ProgrammierTricksEntities db = new ProgrammierTricksEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var languages = (from l in db.ProgrammingLanguages
                                 select l).ToList();
                ddlLanguage.DataSource = languages;
                ddlLanguage.DataBind();
            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (IsValid) {
                string title = txtTitle.Text;
                string description = txtDescription.Text;
                string content = "";
                var reader = new StringReader(txtTrickContent.Text);
                string line;
                while (null != (line = reader.ReadLine()))
                {
                    line = line + "<br/>";
                    content += line;
                }
                DateTime date = DateTime.Today;
                Guid language = Guid.Parse(ddlLanguage.SelectedValue);
                string userId = User.Identity.GetUserId();
                Guid trickId = Guid.NewGuid();
                var item = new Trick();
                item.TricksId = trickId;
                item.Title = title;
                item.UploadDate = date;
                item.TrickContent = content;
                item.Description = description;
                item.Language = language;
                item.AuthorId = userId;

                db.Tricks.Add(item);
                try
                {
                    db.SaveChanges();
                    Response.Redirect("~/Default.aspx");
                }
                catch(DbEntityValidationException ex)
                {
                    lblError.Text = ex.Message;
                }
                catch (Exception ex)
                {
                    lblError.Text = ex.Message;
                }
            }
        }
    }
}