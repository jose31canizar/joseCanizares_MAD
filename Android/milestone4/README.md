## Reflection

I thought Scout was a great idea from the start simply because it had a great functional purpose.
Searching for CU courses isn't the cleanest thing to do online since MyCUInfo and classes.colorado.edu
are a bit messy in the UI and do not provide information that students are really looking for.
Scout offers you ratings, course averages, and difficulty which I think are things that should
be mentioned even before the description of the course.

In terms of creativity, the UI was kept simple enough so display the data from firebase cleanly and without
any complication. I used a scrollview for the classes with little styling to make the app more focused
on the data being displayed rather than distract the user.

What I would have done differently was I would have used a different database that wasn't NoSql. The reason for
this is because querying the database was pretty slowly because it would search without looking up in separate tables
for efficiency. There might be another way to query a firebase database but some other sql database could have been
better. A lot of repetitive code was written in this project as well, so I would have rather made my code much more modular
(such as making a class for a course).
