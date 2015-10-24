--dbus.lua
-- /usr/include/dbus-1.0
-- /usr/lib/x86_64-linux-gnu/libdbus-glib-1.so.2
-- /usr/lib/x86_64-linux-gnu/libdbus-1.so

local ffi = require("ffi")


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


local exports = {
	Lib_dbus = Lib_dbus;
}
setmetatable(exports, {
	__index = function(self, key)
		-- try looking in the library
		local success, value = pcall(function() return Lib_dbus[key] end)
		if success then
			rawset(self, key, value);
			return value;
		end

		-- try looking in the ffi.C namespace
		success, value = pcall(function() return ffi.C[key] end)
		if success then
			rawset(self, key, value);
			return value;
		end

		return nil;
	end,
})

return exports