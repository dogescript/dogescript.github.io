---
layout: wiki
title: index
---
{% include JB/setup %}

This is the index of all pages on the `Dogescript` wiki!
[Click here for the main page](Home.html).

<ul class="posts">
  {% loop_directory directory:wiki iterator:file filter:*.md %}
    <li><a href="{{ file }}.html">{{ file }}</a></li>
  {% endloop_directory %}
</ul>

