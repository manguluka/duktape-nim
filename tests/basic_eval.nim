# import ../duktape/js
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