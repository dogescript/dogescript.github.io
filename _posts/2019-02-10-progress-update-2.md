---
layout: post
title: "Progress Update 2"
description: ""
category: 
tags: []
---
{% include JB/setup %}

# Progress Update 2019-02

## Where we are at

These posts aim to provide a little progress update on milestones or things completed.

### Parser Work

The parser has been reworked to be recursive! The first feature that is going to take advantage of this is support of [`obj` without being declared in the same statement as `very`](https://github.com/dogescript/dogescript/pull/184)

With recursion, comes a set of unforseen problems, which we'll have to address and work around (even if in a less than ideal manner). 

The biggest one is the determination of closing the statement. Since our parser is built to parse on a per line basis, we can't assume that the current line is the last input it will receive. Which forces us to assume when a `;` should be included. 

We currently do it when:

* a `very` token is seen, we assume it's a single line variable declaration.
  * except when declaring an `obj` (we already keep track of this)
* when a function invocation is seen (`plz` or `dose`) unless the argument or function have a `&` (chaining)

An explicit `next` can be used to force a `;`, which is only suppored in the `much` (for loop) case. 

So, in the recursive flow, we have to keep track of what state we're in (chaining/multiline object) and check if it's appropriate to insert a `;` or not. 

The second challenge introduced by recursion is the usage of `isDogescriptSource`, where we determine if we can handle the tokens or not. A discussion on its removal can be found [here](https://github.com/dogescript/dogescript/issues/182)

This function lets us determine whether we can process things or not, if we can't we just return what was given to us. This currently lets us seaminglessly integrate `js` and `djs`. However, as we expand on the tokens that currently are not supported outside of control flow (`bigger` amongst other comparison operators), this function will start to lose it's usefulness. 

Removing it would make us lose the ability to do:

```js
var multiline is `
such 
multiline
`
plz console.loge with multiline
```

Which might brake passivity with the 2.4 version. An alternative to this is to introduce a `nodoge` / `dogeon` construct to explicitly have `js` supported. We can also potentially fix part of the unsupported bits with a [re-write of the `tokenizer` logic](https://github.com/dogescript/dogescript/issues/177)

So, our introduction of recursion was beneficial but will come with its challenges.

### Things we've fixed

* [Function calls without args throw TypeError](https://github.com/dogescript/dogescript/issues/176) - updated parser to throw a syntax error with more information on what is not supported
* [Preserve spacing in single line comment](https://github.com/dogescript/dogescript/pull/180)

## What we'll focus on

Support for the operators outside of control flow, which will let us remove the special logic we do with `rly`/`notrly`/`but` and defer to recursively handling the tokens.

### Issues

* [Support escaped quotes](https://github.com/dogescript/dogescript/issues/177)

### Enhancements

* [Support `obj`](https://github.com/dogescript/dogescript/pull/184)

Carry over from last month.

* A `return` keyword, as an optional companion for `wow [return]`
* Introduction of `thx` as a companion to `&` for not terminating a statement
* [operators for `x.y` and `a[b]`](https://github.com/dogescript/dogescript/issues/128)
* [Ambiguity reductions](https://github.com/dogescript/dogescript/issues/115#issuecomment-449425489)