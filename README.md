Duktape-nim is a [Nim](https://nim-lang.org/) wrapper for the [Duktape](http://duktape.org) embeddable Javascript engine.

## Installation

Use [Nimble](https://github.com/nim-lang/nimble):

```
> nimble install duktape

> git clone https://github.com/manguluka/duktape-nim
> cd duktape-nim
> nimble install -y
```

## Usage

### Interpret Javascript expression

```nim
import duktape/js

# Create duktape context
var ctx = duk_create_heap_default()

# interpret Javascript expression
ctx.duk_eval_string( "1+20");
# Retreive value of last expression as an int
assert ctx.duk_get_int(-1) == 21

# interpret Javascript expression
ctx.duk_eval_string( "'foo'+'bar'+1");
# Retreive value of last expression as a string
assert ctx.duk_get_string(-1) == "foobar1"

# Cleanup duktape memory
ctx.duk_destroy_heap();
```

### Bind Nim proc and call from Javascript

```nim
import duktape/js

# Define proc to be bound
var println: DTCFunction = (proc (ctx: DTContext): cint{.stdcall.} =
    echo duk_to_string(ctx, 0)
)

# Create duktape context
var ctx = duk_create_heap_default()

# Bind proc to the context and global "println" variable 
var err = ctx.duk_push_c_function( println, cast[cint](-1))
var r = ctx.duk_put_global_string("println")

# Call bound proc from Javascript
ctx.duk_eval_string( "println('foobar'+2)");

# Cleanup duktape memory
ctx.duk_destroy_heap();
```

## Credits
Duktape-nim depends on [nimgen](https://github.com/genotrance/nimgen) and [c2nim](https://github.com/nim-lang/c2nim/).

