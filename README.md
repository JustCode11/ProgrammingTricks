# ProgrammingTricks

## Description

A blog where user can post a programming trick and other user can comment on that entry. After a user is 
logged in he can watch on his user profile all his entries and the number of comments he left. He can also
change his password there.

## Technical details

This program is created with ASP.NET and webforms. I used ASP.NET identity for the authentication and authorization
of the user. The data is saved in a local SQL Database and I used entity framework to access the data. I used a
gridview for all the blog entries. This entries can be sorted by date or by the programming languages.
From there you can select a entry and the details of that entry are shown in a detailsview.
The detailsview contains a listview with all the comments for this specific entry. You can only comment or create a
new blog entry if you are logged in. The form where you insert a new entry uses validation controls and a dropdown field
that uses the data from the database. The program has a master page where the header bar is located and the packages
like bootstrap and jquery are inserted. For the log in, sign in and password change, the methods from ASP.NET identity
are used. In the comment section the comments that the blog author has made are marked. I used mostly bootstrap
for designing the program.

## Used packages

- ASP.NET Framework 4.7.2
- Bootstrap 4.6.0
- EntityFramework 6.2.0
- JQuery 3.6.0

## Preview

![Main](./ProgrammingTricks/Content/gifs/programmingTricksMain.gif)
*Overview*

![Login](./ProgrammingTricks/Content/gifs/programmingTricksLogin.gif)
*Login process*

![Create](./ProgrammingTricks/Content/gifs/programmingTricksCreate.gif)
*Create new entrie*
