import unittest
import duktape/js

suite "duktape-nim suite":
 test "that pcompile with bad code works":
   var ctx = duk_create_heap_default()
   var res = ctx.duk_pcompile_string(0, "println('asdf'")
   check res != 0
   # Cleanup duktape memory
   ctx.duk_destroy_heap();

 test "that pcompile with bad code gives message":
   var ctx = duk_create_heap_default()
   var res = ctx.duk_pcompile_string(0, "println('asdf'")
   check res != 0

   check $ctx.duk_safe_to_string(-1) == "SyntaxError: parse error (line 1)"
   ctx.duk_destroy_heap();

 test "that pcompile works with good code":
   var ctx = duk_create_heap_default()
   var res = ctx.duk_pcompile_string(0, "33 + 27")
   check res == 0
   if ctx.duk_pcall(0) != 0:
     echo $ctx.duk_safe_to_string(-1)
   else:
     check ctx.duk_to_number(-1) == 60

   ctx.duk_destroy_heap();
