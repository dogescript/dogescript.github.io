---
layout: post
title: "State of Doge 3"
description: ""
category: 
tags: []
---
{% include JB/setup %}


## Where we are at

These posts aim to provide a little progress update on milestones or things completed.

### Parser Work

The parser has been enhanced with expression support for more operators: 

* [Comparison operators as expressions](https://github.com/dogescript/dogescript/pull/186)
* [support binary ops as expressions](https://github.com/dogescript/dogescript/pull/191)

Which makes `foo bigger 5` now a valid dogescript statement.

With this addition and the modification for [assignment operators on first token](https://github.com/dogescript/dogescript/pull/198), things that were limited to `very x is y` can now exist without the `very` statement. 

This introduction of qualifying on `is` as a top level token also introduces a challenge due to the ambiguity between `is->=` and `is->===`. 

Expression support was also added to the `rly` [control flow keyword](https://github.com/dogescript/dogescript/pull/200), which gives us the ability to write:

```
rly plz foo thx
wow
```

Transforming it to
```
if(foo()) {

}
```

But wait a second, what's this `thx` token???. 

### Things we've added

### Thx

That's a new token which indicates that a function call [with](https://github.com/dogescript/dogescript/pull/199) or [without](https://github.com/dogescript/dogescript/pull/195) arguments should be ended with a `)` without a breaking line.

This is different from using `&` which adds a `)\n` to the expression. 

Prior to this, we would have chained call code that looked something like this:

```
plz foo&
.plz baz&
.plz bar
```

Producing:
```
foo()
.baz()
.bar();
```

Now, with the introduction of recursive parsing and the `thx` keyword, chained function calls can be a single line!

```
plz foo thx .plz bar thx .plz baz
```

Converted to:
```
foo().bar().baz();
```

While the usage of `thx` might seem silly in this case, where we saw a need for this was during control flow execution, as it makes it more clear when arguments end:

```
rly plz fib with 5 thx bigger 6
wow
```

Produces:
```
if (fib(5) > 6) {

}
```

While using the `&`: `rly plz fib with 5& bigger 6` would yield
```
if ( fib(5)
> 6) {

}
```

Why not just make `&` not append a new line? Well, we considered that changing the format would be a bit non-passive (now your whole new line is missing) and we didn't want to change the resulting output.

### Property Acccessors

A [while ago](https://github.com/dogescript/dogescript/issues/35) some suggestions for operators that replace the `.` and `[x]` property accession were proposed. 

Well, we finally implemented them!

The first one is [`giv`](https://github.com/dogescript/dogescript/pull/192) which replaces the `.` operator, 
`document giv window` -> `document.window`.

The second operator is for array style (or map style) property access, [`levl`](https://github.com/dogescript/dogescript/pull/197). `array level 0` -> `array[0]`. 

Both operators can be the result of an assignment, or can be used to assign values!


### Things we've fixed

* A bug was introduced during some refactoring [that breaks json](https://github.com/dogescript/dogescript/issues/187)

## What we'll focus on

Now that we have expression support in control flow, there's a couple of things we need to wrap up:

* make all control flow statements stop relying on the `controlFlowParser` function (and use the same parsing function as everything else)
* add more support for expressions that were used in control flow only (`as` , `next`)
* Address the ambiguity of `much`

With that last point, we'll also be looking at making function invocations support nested calls: https://github.com/dogescript/dogescript/issues/201

We'll also focus on better tokenization approaches: https://github.com/dogescript/dogescript/issues/177

With those improvements out of the way, we'll be in a good spot to start adding more keywords to support [`class`](https://github.com/dogescript/dogescript/issues/126) declarations, and everything that comes with them.

If you have ideas for other keywords:

* [explicit return](https://github.com/dogescript/dogescript/issues/174)
* [do/while , try/catch/finally, instanceof/typeof](https://github.com/dogescript/dogescript/issues/114)

Feel free to drop a comment on those issues.