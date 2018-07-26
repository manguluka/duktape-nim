# import ../duktape/js
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
ctx.duk_eval_string( "println('foobar'+1)");

# Cleanup duktape memory
ctx.duk_destroy_heap();