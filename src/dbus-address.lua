local ffi = require("ffi")

require("dbus-types")
require("dbus-errors")


ffi.cdef[[
/** Opaque type representing one of the semicolon-separated items in an address */
typedef struct DBusAddressEntry DBusAddressEntry;


dbus_bool_t dbus_parse_address            (const char         *address,
					   DBusAddressEntry ***entry,
					   int                *array_len,
					   DBusError          *error);

const char *dbus_address_entry_get_value  (DBusAddressEntry   *entry,
					   const char         *key);

const char *dbus_address_entry_get_method (DBusAddressEntry   *entry);

void        dbus_address_entries_free     (DBusAddressEntry  **entries);


char* dbus_address_escape_value   (const char *value);

char* dbus_address_unescape_value (const char *value,
                                   DBusError  *error);
]]


