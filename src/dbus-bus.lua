local ffi = require("ffi")

require("dbus-connection")


ffi.cdef[[

DBusConnection *dbus_bus_get              (DBusBusType     type,
					   DBusError      *error);

DBusConnection *dbus_bus_get_private      (DBusBusType     type,
					   DBusError      *error);


dbus_bool_t     dbus_bus_register         (DBusConnection *connection,
					   DBusError      *error);

dbus_bool_t     dbus_bus_set_unique_name  (DBusConnection *connection,
					   const char     *unique_name);

const char*     dbus_bus_get_unique_name  (DBusConnection *connection);

unsigned long   dbus_bus_get_unix_user    (DBusConnection *connection,
			                   const char     *name,
                                           DBusError      *error);

char*           dbus_bus_get_id           (DBusConnection *connection,
                                           DBusError      *error);

int             dbus_bus_request_name     (DBusConnection *connection,
					   const char     *name,
					   unsigned int    flags,
					   DBusError      *error);

int             dbus_bus_release_name     (DBusConnection *connection,
					   const char     *name,
					   DBusError      *error);

dbus_bool_t     dbus_bus_name_has_owner   (DBusConnection *connection,
					   const char     *name,
					   DBusError      *error);


dbus_bool_t     dbus_bus_start_service_by_name (DBusConnection *connection,
                                                const char     *name,
                                                dbus_uint32_t   flags,
                                                dbus_uint32_t  *reply,
                                                DBusError      *error);


void            dbus_bus_add_match        (DBusConnection *connection,
                                           const char     *rule,
                                           DBusError      *error);

void            dbus_bus_remove_match     (DBusConnection *connection,
                                           const char     *rule,
                                           DBusError      *error);
]]

