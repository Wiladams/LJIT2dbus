local ffi = require("ffi")

require ("dbus-arch-deps")

ffi.cdef[[
typedef dbus_uint32_t  dbus_unichar_t;
typedef dbus_uint32_t  dbus_bool_t;
]]

ffi.cdef[[
typedef dbus_uint64_t DBus8ByteStruct;
]]


ffi.cdef[[
/**
 * A simple value union that lets you access bytes as if they
 * were various types; useful when dealing with basic types via
 * void pointers and varargs.
 *
 * This union also contains a pointer member (which can be used
 * to retrieve a string from dbus_message_iter_get_basic(), for
 * instance), so on future platforms it could conceivably be larger
 * than 8 bytes.
 */
typedef union
{
  unsigned char bytes[8]; /**< as 8 individual bytes */
  dbus_int16_t  i16;   /**< as int16 */
  dbus_uint16_t u16;   /**< as int16 */
  dbus_int32_t  i32;   /**< as int32 */
  dbus_uint32_t u32;   /**< as int32 */
  dbus_bool_t   bool_val; /**< as boolean */
  dbus_int64_t  i64;   /**< as int64 */
  dbus_uint64_t u64;   /**< as int64 */
  DBus8ByteStruct eight; /**< as 8-byte struct */
  double dbl;          /**< as double */
  unsigned char byt;   /**< as byte */
  char *str;           /**< as char* (string, object path or signature) */
  int fd;              /**< as Unix file descriptor */
} DBusBasicValue;
]]
