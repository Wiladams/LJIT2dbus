local ffi = require("ffi")

require("dbus-errors")
require("dbus-message")
require("dbus-connection")
require("dbus-protocol")


ffi.cdef[[
typedef struct DBusServer DBusServer;

/** Called when a new connection to the server is available. Must reference and save the new
 * connection, or close the new connection. Set with dbus_server_set_new_connection_function().
 */
typedef void (* DBusNewConnectionFunction) (DBusServer     *server,
                                            DBusConnection *new_connection,
                                            void           *data);
]]

ffi.cdef[[

DBusServer* dbus_server_listen           (const char     *address,
                                          DBusError      *error);

DBusServer* dbus_server_ref              (DBusServer     *server);

void        dbus_server_unref            (DBusServer     *server);

void        dbus_server_disconnect       (DBusServer     *server);

dbus_bool_t dbus_server_get_is_connected (DBusServer     *server);

char*       dbus_server_get_address      (DBusServer     *server);

char*       dbus_server_get_id           (DBusServer     *server);

void        dbus_server_set_new_connection_function (DBusServer                *server,
                                                     DBusNewConnectionFunction  function,
                                                     void                      *data,
                                                     DBusFreeFunction           free_data_function);

dbus_bool_t dbus_server_set_watch_functions         (DBusServer                *server,
                                                     DBusAddWatchFunction       add_function,
                                                     DBusRemoveWatchFunction    remove_function,
                                                     DBusWatchToggledFunction   toggled_function,
                                                     void                      *data,
                                                     DBusFreeFunction           free_data_function);

dbus_bool_t dbus_server_set_timeout_functions       (DBusServer                *server,
                                                     DBusAddTimeoutFunction     add_function,
                                                     DBusRemoveTimeoutFunction  remove_function,
                                                     DBusTimeoutToggledFunction toggled_function,
                                                     void                      *data,
                                                     DBusFreeFunction           free_data_function);

dbus_bool_t dbus_server_set_auth_mechanisms         (DBusServer                *server,
                                                     const char               **mechanisms);


dbus_bool_t dbus_server_allocate_data_slot (dbus_int32_t     *slot_p);

void        dbus_server_free_data_slot     (dbus_int32_t     *slot_p);

dbus_bool_t dbus_server_set_data           (DBusServer       *server,
                                            int               slot,
                                            void             *data,
                                            DBusFreeFunction  free_data_func);

void*       dbus_server_get_data           (DBusServer       *server,
                                            int               slot);
]]

