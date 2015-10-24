local ffi = require("ffi")

require("dbus-macros")
require("dbus-types")
require("dbus-errors")



ffi.cdef[[
dbus_bool_t     dbus_validate_path                   (const char *path,
                                                      DBusError  *error);

dbus_bool_t     dbus_validate_interface              (const char *name,
                                                      DBusError  *error);

dbus_bool_t     dbus_validate_member                 (const char *name,
                                                      DBusError  *error);

dbus_bool_t     dbus_validate_error_name             (const char *name,
                                                      DBusError  *error);

dbus_bool_t     dbus_validate_bus_name               (const char *name,
                                                      DBusError  *error);

dbus_bool_t     dbus_validate_utf8                   (const char *alleged_utf8,
                                                      DBusError  *error);
]]
