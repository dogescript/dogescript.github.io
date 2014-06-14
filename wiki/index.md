---
layout: page
title:  Wiki Index
---
{% include JB/setup %}

This is the index of all pages on the Dogescript wiki!
[Click here for the main page](Home).

<ul class="posts">
  {% loop_directory directory:wiki iterator:file filter:* %}
    {% if file != 'index.md' %}
      <li><a href="{{ file }}">{{ file }}</a></li>
    {% endif %}
  {% endloop_directory %}
</ul>
