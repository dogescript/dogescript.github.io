# dogescript.github.io

This is the source code of the **Dogescript homepage**.
This `README` specifies how to update the website and do maintenance tasks.

If you're after the **Dogescript language** itself, see the following links:

* [Dogescript homepage][home];
* [Dogescript source code on GitHub][hub];
* [Dogescript organization on GitHub][org];

## Intro

This homepage is a *static site*; meaning that for each modification you have
to regenerate the website and upload it.

It uses the [Jekyll][jekyll] engine to automate this process. Since Jekyll
is written in Ruby you have to install a few Ruby packages (called _Ruby Gems_).

Finally, there are some `rake` tasks to ease the whole process of maintaining
the website

## Dependencies

You must have the [RubyGems][gems] package manager installed. Note that it
comes by default on many distributions, so check if it exists with the following
command:

    $ gem --version

Then, to install `rake` (Ruby's version of `make`), Jekyll and all dependencies
to run this site, do the following command:

    $ gem install rake jekyll

It might take a while to finish, but once it does you're ready to go.

## How to edit

To **make changes** to the page or **run it locally**, clone this GitHub
repository and make sure you have _installed the dependencies_ above.

Then, it's a matter of running `rake` tasks and editing files.
Here's a rundown of possible commands (thanks to [this great quickstart on Jekyll][tuto]):

---

    $ rake preview

Builds the entire site to a local folder `_site` and launches a webserver to
preview it.

To see the full site, point your browser to `localhost:4000`.

If you make any changes on any files, it will regenerate the website
automatically.

---

    $ rake post title="Hello, World!"

Creates a new post. It will create a file `_posts/YYYY-MM-DD-title.md`, where
the date is the current, by default.

No further changes are required, the post will get automatically inserted on the
site.

---

    $ rake page name="about"

Creates a new page. It will create the file `./about/index.html`.

    $ rake page name="about.html"

Alternative way to create a new page, on this case it will be `./about.html`.

---

    $ rake wiki name="user/repo"

Updates the GitHub Wiki pages from GitHub `user` and `repo` into the directory `./wiki`.

It works by either cloning the remote wiki repository (if it doesn't exist
on `./wiki` yet) or pulling the latest update (if it's already there).
Then it adds a small YAML metadata header to each page, making it able to
work as a page.

So when you visit `./wiki` it nicely shows all wiki pages.

## Notes

* When producing content (writing pages/posts) keep in mind
  [this useful guide][posts]. It tells how to include images, display
  post excerpts and highlight code snippets.
* If you plan on further customizing the blog, it's highly recommended to
  read [this 10-minute introduction to Jekyll][intro].
* If you change settings on the file `_config.yml`, automatic regeneration won't
  work - you'll have to run the command `rake preview` again.

## Credits

This site uses [Jekyll Bootstrap][boots] with a heavily customized version of
[the_minimum][theme] theme.

[home]:         http://dogescript.com/
[hub]:          https://github.com/dogescript/dogescript/
[org]:          https://github.com/dogescript/
[jekyll]:       http://jekyllrb.com/
[gems]:         https://rubygems.org/pages/download
[tuto]:         http://jekyllbootstrap.com/usage/jekyll-quick-start.html
[intro]:        http://jekyllbootstrap.com/lessons/jekyll-introduction.html
[boots]:        http://jekyllbootstrap.com/
[theme]:        https://github.com/jekyllbootstrap/theme-the-program
[posts]:        http://jekyllrb.com/docs/posts/

