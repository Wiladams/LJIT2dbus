# LJIT2dbus
LuaJIT binding to libdbus

This is a LuaJIT binding to the low level C API.  It utilizes the reference implementation
library (libdbus-1.so).

If you want to target another implementation, you can simply change the ffi.load() found within
the dbus.lua file.

There are two levels at which you can use this binding.

At the lowest level, you can use it just like you would the raw 'C' binding.

```lua
local dbus = require("dbus")

local str = dbus.dbus_get_local_machine_id();
str = ffi.string(str)
```

If you want to use a more object oriented approach, you can use the various high level 
objects which are available

* LBusContext    - Miscellaneous stuff not tied to a particular class
* LBusBus        - Represents the Bus itself, also a sub-class of LBusConnection
* LBusConnection - A connection to a Bus
* LBusMessage    - Encapsulates a single message

```lua
local bus = LBusBus(dbus.DBUS_BUS_SESSION)
assert(bus:nameHasOwner(SYSNOTE_NAME)

local msg = LBusMessage:newMethodCall(SYSNOTE_NAME, SYNOTE_PATH, SYSNOTE_IFACE, SYSNOTE_NOTE);
msg:setNoreply(true)

assert(msg:addArg("Hello, World");
assert(msg:addArg("");
assert(msg:addArg(1);

bus:send(msg)
```

Using the 'object' interface makes using the code at least as easy as other language bindings.

As well as the basics, the object binding provides nice integration with Lua idioms, such as iterators.

```lua
local msg = LBusMessage:newMethodCall(name,  path, interface, note);
msg:addArg("Hello, World");
msg:addArg("");
msg:addArg(1)

-- iterate over the arguments, printing out their values
for _, anArg in msg:args() do
  print(anArg)
end
```

In this case, the 'anArg' will be of Lua native type.  So, a 'char *' will be a 'string' and the
various numeric types will become 'number'.

Still more to do in order to make it even easier to use, and to provide introspection, and support 
of more of the base types, such as arrays.

