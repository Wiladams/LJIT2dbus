local ffi = require("ffi")

require("dbus-types")
require("dbus-errors")


ffi.cdef[[
char*       dbus_get_local_machine_id  (void);

void        dbus_get_version           (int *major_version_p,
                                        int *minor_version_p,
                                        int *micro_version_p);
]]


