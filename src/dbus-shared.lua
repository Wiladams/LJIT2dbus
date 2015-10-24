local ffi = require("ffi")

local C = {}

ffi.cdef[[
// Well-known bus types. See dbus_bus_get().
typedef enum
{
  DBUS_BUS_SESSION,    //*< The login session bus
  DBUS_BUS_SYSTEM,     //*< The systemwide bus 
  DBUS_BUS_STARTER     //*< The bus that started us, if any
} DBusBusType;



// Results that a message handler can return.
typedef enum
{
  DBUS_HANDLER_RESULT_HANDLED,         //*< Message has had its effect - no need to run more handlers.
  DBUS_HANDLER_RESULT_NOT_YET_HANDLED, //*< Message has not had any effect - see if other handlers want it.
  DBUS_HANDLER_RESULT_NEED_MEMORY      //*< Need more memory in order to return #DBUS_HANDLER_RESULT_HANDLED or #DBUS_HANDLER_RESULT_NOT_YET_HANDLED. Please try again later with more memory.
} DBusHandlerResult;
]]


-- Bus names

-- The bus name used to talk to the bus itself.
C.DBUS_SERVICE_DBUS  =    "org.freedesktop.DBus"

-- Paths
-- The object path used to talk to the bus itself.
C.DBUS_PATH_DBUS  = "/org/freedesktop/DBus"
-- The object path used in local/in-process-generated messages.
C.DBUS_PATH_LOCAL = "/org/freedesktop/DBus/Local"


--[[ Interfaces, these C.don't do much other than
 * catch typos at compile time
 --]]


-- The interface exported by the object with #DBUS_SERVICE_DBUS and #DBUS_PATH_DBUS --]]
C.DBUS_INTERFACE_DBUS  =         "org.freedesktop.DBus"
-- The interface supported by introspectable objects --]]
C.DBUS_INTERFACE_INTROSPECTABLE ="org.freedesktop.DBus.Introspectable"
-- The interface supported by objects with properties --]]
C.DBUS_INTERFACE_PROPERTIES     ="org.freedesktop.DBus.Properties"
-- The interface supported by most dbus peers --]]
C.DBUS_INTERFACE_PEER           ="org.freedesktop.DBus.Peer"


--[[* This is a special interface whose methods can only be invoked
 * by the local implementation (messages from remote apps aren't
 * allowed to specify this interface).
 --]]
 

C.DBUS_INTERFACE_LOCAL ="org.freedesktop.DBus.Local"

--[[ Owner flags --]]
C.DBUS_NAME_FLAG_ALLOW_REPLACEMENT =0x1 --[[*< Allow another service to become the primary owner if requested --]]
C.DBUS_NAME_FLAG_REPLACE_EXISTING  =0x2 --[[*< Request to replace the current primary owner --]]
C.DBUS_NAME_FLAG_DO_NOT_QUEUE      =0x4 --[[*< If we can not become the primary owner do not place us in the queue --]]

--[[ Replies to request for a name --]]
C.DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER  =1 --[[*< Service has become the primary owner of the requested name --]]
C.DBUS_REQUEST_NAME_REPLY_IN_QUEUE       =2 --[[*< Service could not become the primary owner and has been placed in the queue --]]
C.DBUS_REQUEST_NAME_REPLY_EXISTS         =3 --[[*< Service is already in the queue --]]
C.DBUS_REQUEST_NAME_REPLY_ALREADY_OWNER  =4 --[[*< Service is already the primary owner --]]

--[[ Replies to releasing a name --]]
C.DBUS_RELEASE_NAME_REPLY_RELEASED        =1 --[[*< Service was released from the given name --]]
C.DBUS_RELEASE_NAME_REPLY_NON_EXISTENT    =2 --[[*< The given name does not exist on the bus --]]
C.DBUS_RELEASE_NAME_REPLY_NOT_OWNER       =3 --[[*< Service is not an owner of the given name --]]

--[[ Replies to service starts --]]
C.DBUS_START_REPLY_SUCCESS         =1 --[[*< Service was auto started --]]
C.DBUS_START_REPLY_ALREADY_RUNNING =2 --[[*< Service was already running --]]

local exports = {
	Constants = C;	
}

return exports