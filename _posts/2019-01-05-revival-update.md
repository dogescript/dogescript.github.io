---
layout: post
title: "Revival Update"
description: "Status update on the road to 2.4 and 3.0"
category:
tags: ['dogescript', 'bloge', 'status update']
---
{% include JB/setup %}

# Progress Update 2019-01

## Where we are at

These posts aim to provide a little progress update on milestones or things completed. Dogescript was in full strength in 2014 and suffered a minor hiatus, however it was picked up again in 2017. This first post is a little light of confidence and inspiration that dogescript will not be forgotten.

Dogescript switched contributors / owners around October 2017th. Most features and bugs were closed and re-consolidated in [2.4 Feature List](https://github.com/dogescript/dogescript/issues/114), with things scoped to the 3.0 version of dogescript also consolidated [here](https://github.com/dogescript/dogescript/issues/115).

### Cadence

I plan on trying to keep these updated on a monthly cadence, even if there's no substantial updates it will at least let you all know that we're still committed to this mission!

### Parser Work

The state of the parser in 2017-10 was a bit unmaintainable, so the focus on the parser switched with these goals in mind:

1. Expression support in conditional statements
2. Info on syntax errors (line / token)
3. Maintainability to more easily add constructs

One of our desired features is to be able to express:

```
if (foo()) // other things
```

In the current dogescript language, a variable needs to be created to write that expression in full dogescript mode:

```
very result is plz foo
rly result
```

One of the challenges faced with the parser is the ambiguity between certain keywords and modes within the control flow statements, like [is](https://github.com/dogescript/dogescript/issues/45). Our approach here has been to make the parser consume tokens as it encounters them to avoid having to duplicate the handling of constructs between a conditional statement and a non-conditional one.

Each top-level keyword forces the parser down a single unique path, avoiding missing features between common paths. This also allows us to expect a particular set of tokens and throw syntax errors with more information on them:

```
 throw new Error(`Invalid parse state! Expected a value but got: '${keys[0]}' from chain: [${keys}]. Allowed construct 'woof [<name> be] <value | <SUCH> | <MUCH> >'`);
 ```

While we can't, currently today, express:

```
rly plz foo
```

The refactoring and re-organizing of the parser will make it easier to support any expression (regardless of validity) by consuming the `rly` token and then treating everything in between as a new expression. We can already do `plz foo` so it's just a matter of combining the two pieces!

### Features/Enhancements

Notable features and enhancements include:

* [module.exports](https://github.com/dogescript/dogescript/pull/131) , `woof foo` -> `module.exports = foo`
* [operator support outside of conditionals](https://github.com/dogescript/dogescript/pull/118) , `foo more 5` now properly translates to `foo += 5`
* [introduction of pre-increment post-increment operators](https://github.com/dogescript/dogescript/pull/123) , `foo bigify` -> `foo++` , `smallify bar` -> `--bar`

## What we'll focus on

### Parser Work

Our biggest focus is recursive parsing, the parser partially handles this by re-creating the input and calling parse again, but a better approach would be to just consume the already parsed keys and support calling that from wherever applicable.

With a recursive approach, we'll break down the construct:

```
rly plz foo
```

Into a path that sort of handles things like this:

* `rly` -> `if ( ${expr} )`
  * `plz foo` -> `foo()`

This recursive-ness will introduce some challenges since the current handling of `plz foo` returns `foo();` (terminating the expression).

Additionally, we wish to be able to also write:

```
rly plz foo bigger random dose nextInt
```

Which introduces ambiguity and parse errors since we consider `plz` to appear in the following forms:

```
plz foo
plz foo with [args]
```

While we currently can control whether `plz foo` produces `foo()` or `foo();`, via `&`, we'd like to introduce a new keyword `thx` to make things a bit more apparent (like one would expect a `)` closing the arguments to a function):

```
rly plz foo thx bigger random dose nextInt
rly plz foo with args thx bigger random dose nextInt
```

The focus on recursiveness will also let us write the following expression in a single line:

```
foo().bar()
```

Currently, this is the way you'd produce this in dogescript

```
plz foo&
dose bar
```

But we'd like to be able to support either

```
plz foo& dose bar
plz foo thx dose bar
```

### Enhancements

A set of possible enhancements we're looking at tackling include:

* A `return` keyword, as an optional companion for `wow [return]`
* Introduction of `thx` as a companion to `&` for not terminating a statement
* [operators for `x.y` and `a[b]`](https://github.com/dogescript/dogescript/issues/128)
* [Ambiguity reductions](https://github.com/dogescript/dogescript/issues/115#issuecomment-449425489)


## Looking far far ahead

A prototype of a [potential 3.0 parser is underway as well](https://github.com/dogescript/dogescript/issues/115#issuecomment-445644892), which has revealed a couple of issues and ambiguities already. One of the objectives of dogescript-2.4.x is the ability to build dogescript-3.0 in dogescript (even if the state of the dogescript-3.0 parser/lexer isn't perfect).
