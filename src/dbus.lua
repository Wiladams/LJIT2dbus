--dbus.lua
-- /usr/include/dbus-1.0
-- /usr/lib/x86_64-linux-gnu/libdbus-glib-1.so.2
-- /usr/lib/x86_64-linux-gnu/libdbus-1.so

DBUS_INSIDE_DBUS_H = true;

require ("dbus-arch-deps");
require ("dbus-address");
require ("dbus-bus");
require ("dbus-connection");
require ("dbus-errors");
require ("dbus-macros");
require ("dbus-message");
require ("dbus-misc");
require ("dbus-pending-call");
require ("dbus-protocol");
require ("dbus-server");
require ("dbus-shared");
require ("dbus-signature");
require ("dbus-syntax");
require ("dbus-threads");
require ("dbus-types");

DBUS_INSIDE_DBUS_H = false;

local Lib_dbus = ffi.load("dbus-1")

return Lib_dbus

