---
layout: post
title: "State of Doge 4"
description: ""
category: 
tags: []
---
{% include JB/setup %}

## Where we are at

These posts aim to provide a little progress update on milestones or things completed.

### Parser Work

The parser has been enhanced with support for explicit returns:

* [amaze](https://github.com/dogescript/dogescript/pull/208)

The `amaze` keyword acts as an explicit return, without closing the current block. Unlike `wow value`, which returns and closes the block.

This keyword will hopefully be used within anonymous functions to clear up ambiguity of whether we close the anonymous function `}`, or close both the anonymous function AND arguments to a function `})`.

So, using amaze:
```
rly foo
amaze 1
wow
```

Without amaze:
```
rly foo
wow 1
```

Both end up transforming to:
```
if ( foo() ) {
  return 1;
}
```

We've also removed the [`controlFlowParser`](https://github.com/dogescript/dogescript/pull/202) so expression support within control flow statements now follows the same logic as the rest.

### Things we've fixed

* A [custom tokenizer](https://github.com/dogescript/dogescript/issues/177) was added to handle escaped quotes

### What we'll focus on

* [class support](https://github.com/dogescript/dogescript/issues/126)
* [do/while , try/catch/finally, instanceof/typeof](https://github.com/dogescript/dogescript/issues/114)
* an explicit `break` keyword, currently just planning on `bork`.