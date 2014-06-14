---
layout: page
title: JavaScript for the moon.
---
<!-- ...everything's a mess, so I'll have to
   - guide you through these comments... -->

{% include JB/setup %}

<!-- INTRODUCTION TEXT -->
Dogescript is a programming language that compiles into JavaScript. While JavaScript is a beautiful language, it's not quite Doge friendly. Thankfully, Dogescript fixes that, so that your code can truly go to the moon.

<a id="wiki-button" href="/live">Try online</a>

## Example

<div id="intro" style="width:100%;height:auto">
  <div id="intro-left">
{% highlight text %}
shh this is dogescript

such goToTheMoon much doge
  very moon is false
  rly doge is 'a doge'
    moon is true
  wow
wow moon
plz goToTheMoon with 'a doge'
{% endhighlight %}
  </div>
</div>

<!-- DOWNLOAD -->


<div><!-- Need to have this div so it links alright -->
<a href="#download" name="download">
<h2>Download</h2>
</a>
</div>

The Dogescript compiler can be installed from npm:

{% highlight bash %}
$ npm install -g dogescript
{% endhighlight %}



<!-- GETTING STARTED
   - things should be better by now...
   - (almost) pure Markdown -->

## Getting started

Dogescript can be used either as a REPL, or as a compiler.

{% highlight bash %}
# Launches a REPL that evaluates Dogescript code,
# converting into Javascript on-the-fly
$ dogescript
DOGE> your dogescript here

# Dogescript files have a `.djs` extension.
# Converts `script.djs` into Javascript,
# prints to standard output
$ dogescript location/to/script.djs

# With the power of Bash, 
# you can redirect stdout into a file
$ dogescript location/to/script.djs > final.js
{% endhighlight %}

For more info, see [the Tutorials page on the Wiki](/wiki/Tutorials) and the links below.

## Links

* [**Full language definition**](https://github.com/dogescript/dogescript/blob/master/LANGUAGE.md): Technical document defining the whole language - what's valid and what's not.
* [**Utilities** made for Dogescript](/wiki/Utilities): syntax highlighters, build plugins and more...
* [**Projects** made with Dogescript](/wiki/Projects): programs, games, anything programmed in Dogescript.

## Credits

* Dogescript was originally made by [Zach Bruggeman](http://zachbruggeman.me)
* Currently maintained by the [Dogescript GitHub Organization](https://github.com/dogescript)
* [Full list of contributors on GitHub](https://github.com/dogescript/dogescript#contributors)
