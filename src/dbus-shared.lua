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
