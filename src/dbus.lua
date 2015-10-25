--dbus.lua
-- /usr/include/dbus-1.0
-- /usr/lib/x86_64-linux-gnu/libdbus-glib-1.so.2
-- /usr/lib/x86_64-linux-gnu/libdbus-1.so

local ffi = require("ffi")

if not DBUS_INCLUDED then

local C = {}

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

C.TRUE = 1;
C.FALSE = 0;

-- Bus names
-- The bus name used to talk to the bus itself.
C.DBUS_SERVICE_DBUS  =    "org.freedesktop.DBus";

-- Paths
-- The object path used to talk to the bus itself.
C.DBUS_PATH_DBUS  = "/org/freedesktop/DBus";
-- The object path used in local/in-process-generated messages.
C.DBUS_PATH_LOCAL = "/org/freedesktop/DBus/Local";


--[[ Interfaces, these C.don't do much other than
 * catch typos at compile time
 --]]


-- The interface exported by the object with #DBUS_SERVICE_DBUS and #DBUS_PATH_DBUS --]]
C.DBUS_INTERFACE_DBUS  =         "org.freedesktop.DBus";
-- The interface supported by introspectable objects --]]
C.DBUS_INTERFACE_INTROSPECTABLE ="org.freedesktop.DBus.Introspectable";
-- The interface supported by objects with properties --]]
C.DBUS_INTERFACE_PROPERTIES     ="org.freedesktop.DBus.Properties";
-- The interface supported by most dbus peers --]]
C.DBUS_INTERFACE_PEER           ="org.freedesktop.DBus.Peer";


--[[* This is a special interface whose methods can only be invoked
 * by the local implementation (messages from remote apps aren't
 * allowed to specify this interface).
 --]]
 

C.DBUS_INTERFACE_LOCAL ="org.freedesktop.DBus.Local";

--[[ Owner flags --]]
C.DBUS_NAME_FLAG_ALLOW_REPLACEMENT =0x1; --[[*< Allow another service to become the primary owner if requested --]]
C.DBUS_NAME_FLAG_REPLACE_EXISTING  =0x2; --[[*< Request to replace the current primary owner --]]
C.DBUS_NAME_FLAG_DO_NOT_QUEUE      =0x4; --[[*< If we can not become the primary owner do not place us in the queue --]]

--[[ Replies to request for a name --]]
C.DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER  =1; --[[*< Service has become the primary owner of the requested name --]]
C.DBUS_REQUEST_NAME_REPLY_IN_QUEUE       =2; --[[*< Service could not become the primary owner and has been placed in the queue --]]
C.DBUS_REQUEST_NAME_REPLY_EXISTS         =3; --[[*< Service is already in the queue --]]
C.DBUS_REQUEST_NAME_REPLY_ALREADY_OWNER  =4; --[[*< Service is already the primary owner --]]

--[[ Replies to releasing a name --]]
C.DBUS_RELEASE_NAME_REPLY_RELEASED        =1; --[[*< Service was released from the given name --]]
C.DBUS_RELEASE_NAME_REPLY_NON_EXISTENT    =2; --[[*< The given name does not exist on the bus --]]
C.DBUS_RELEASE_NAME_REPLY_NOT_OWNER       =3; --[[*< Service is not an owner of the given name --]]

--[[ Replies to service starts --]]
C.DBUS_START_REPLY_SUCCESS         =1; --[[*< Service was auto started --]]
C.DBUS_START_REPLY_ALREADY_RUNNING =2; --[[*< Service was already running --]]


local Lib_dbus = ffi.load("dbus-1")


local exports = {
	Lib_dbus = Lib_dbus;
}
setmetatable(exports, {
	__index = function(self, key)
		local value = nil;
		local success = false;

		-- try looking in table of constants
		value = C[key]
		if value then
			rawset(self, key, value)
			return value;
		end


		-- try looking in the library for a function
		success, value = pcall(function() return Lib_dbus[key] end)
		if success then
			rawset(self, key, value);
			return value;
		end

		-- try looking in the ffi.C namespace, for constants
		-- and enums
		success, value = pcall(function() return ffi.C[key] end)
		--print("looking for constant/enum: ", key, success, value)
		if success then
			rawset(self, key, value);
			return value;
		end

		-- Or maybe it's a type
		success, value = pcall(function() return ffi.typeof(key) end)
		if success then
			rawset(self, key, value);
			return value;
		end

		return nil;
	end,
})

DBUS_INCLUDED = exports
end

return DBUS_INCLUDED