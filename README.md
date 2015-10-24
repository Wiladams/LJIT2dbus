# LJIT2dbus
LuaJIT binding to libdbus

This is a LuaJIT binding to the low level C API.  It utilizes the reference implementation
library (libdbus-1.so).

If you want to target another implementation, you can simply change the ffi.load() found within
the dbus.lua file.

As a rudimentary binding, there are not yet any Lua specific convenience methods.  So, at
the moment (Oct 23, 2015), it's good for writing and experimenting with code that goes
against the raw low level C interface.

Simpler higher level object interfaces will be built atop this.