local ffi = require("ffi")

require("dbus-macros")
require("dbus-types")
require("dbus-connection")

local int = ffi.typeof("int")

-- These should not be global
ffi.cdef[[
static const int DBUS_TIMEOUT_INFINITE = ((int)0x7fffffff);
static const int DBUS_TIMEOUT_USE_DEFAULT = ((int)-1);
]]

ffi.cdef[[

DBusPendingCall* dbus_pending_call_ref       (DBusPendingCall               *pending);

void         dbus_pending_call_unref         (DBusPendingCall               *pending);

dbus_bool_t  dbus_pending_call_set_notify    (DBusPendingCall               *pending,
                                              DBusPendingCallNotifyFunction  function,
                                              void                          *user_data,
                                              DBusFreeFunction               free_user_data);

void         dbus_pending_call_cancel        (DBusPendingCall               *pending);

dbus_bool_t  dbus_pending_call_get_completed (DBusPendingCall               *pending);

DBusMessage* dbus_pending_call_steal_reply   (DBusPendingCall               *pending);

void         dbus_pending_call_block         (DBusPendingCall               *pending);


dbus_bool_t dbus_pending_call_allocate_data_slot (dbus_int32_t     *slot_p);

void        dbus_pending_call_free_data_slot     (dbus_int32_t     *slot_p);

dbus_bool_t dbus_pending_call_set_data           (DBusPendingCall  *pending,
                                                  dbus_int32_t      slot,
                                                  void             *data,
                                                  DBusFreeFunction  free_data_func);

void*       dbus_pending_call_get_data           (DBusPendingCall  *pending,
                                                  dbus_int32_t      slot);
]]

