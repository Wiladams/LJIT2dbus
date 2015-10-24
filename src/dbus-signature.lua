local ffi = require("ffi")

require("dbus-macros")
require("dbus-types")
require("dbus-errors")


ffi.cdef[[
/**
 * DBusSignatureIter struct; contains no public fields 
 */
typedef struct
{ 
  void *dummy1;         /**< Don't use this */
  void *dummy2;         /**< Don't use this */
  dbus_uint32_t dummy8; /**< Don't use this */
  int dummy12;           /**< Don't use this */
  int dummy17;           /**< Don't use this */
} DBusSignatureIter;
]]

ffi.cdef[[
void            dbus_signature_iter_init             (DBusSignatureIter       *iter,
						      const char              *signature);


int             dbus_signature_iter_get_current_type (const DBusSignatureIter *iter);


char *          dbus_signature_iter_get_signature    (const DBusSignatureIter *iter);


int             dbus_signature_iter_get_element_type (const DBusSignatureIter *iter);


dbus_bool_t     dbus_signature_iter_next             (DBusSignatureIter       *iter);


void            dbus_signature_iter_recurse          (const DBusSignatureIter *iter,
						      DBusSignatureIter       *subiter);


dbus_bool_t     dbus_signature_validate              (const char       *signature,
						      DBusError        *error);


dbus_bool_t     dbus_signature_validate_single       (const char       *signature,
						      DBusError        *error);


dbus_bool_t     dbus_type_is_valid                   (int            typecode);


dbus_bool_t     dbus_type_is_basic                   (int            typecode);

dbus_bool_t     dbus_type_is_container               (int            typecode);

dbus_bool_t     dbus_type_is_fixed                   (int            typecode);
]]
