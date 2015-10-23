local ffi = require("ffi")


require("dbus-macros")
require("dbus-types")
require("dbus-protocol")




ffi.cdef[[
/** Mostly-opaque type representing an error that occurred */
typedef struct DBusError DBusError;
]]

ffi.cdef[[
/**
 * Object representing an exception.
 */
struct DBusError
{
  const char *name;    /**< public error name field */
  const char *message; /**< public error message field */

  unsigned int dummy1 : 1; /**< placeholder */
  unsigned int dummy2 : 1; /**< placeholder */
  unsigned int dummy3 : 1; /**< placeholder */
  unsigned int dummy4 : 1; /**< placeholder */
  unsigned int dummy5 : 1; /**< placeholder */

  void *padding1; /**< placeholder */
};
]]

local function DBUS_ERROR_INIT()
  return ffi.new("struct DBusError", { NULL, NULL, TRUE, 0, 0, 0, 0, NULL });
end


ffi.cdef[[
void        dbus_error_init      (DBusError       *error);
void        dbus_error_free      (DBusError       *error);
void        dbus_set_error       (DBusError       *error,
                                  const char      *name,
                                  const char      *message,
                                  ...);
void        dbus_set_error_const (DBusError       *error,
                                  const char      *name,
                                  const char      *message);
void        dbus_move_error      (DBusError       *src,
                                  DBusError       *dest);
dbus_bool_t dbus_error_has_name  (const DBusError *error,
                                  const char      *name);
dbus_bool_t dbus_error_is_set    (const DBusError *error);
]]

