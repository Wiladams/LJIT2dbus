local ffi = require("ffi")

require("dbus-macros")


ffi.cdef[[

void* dbus_malloc        (size_t bytes);


void* dbus_malloc0       (size_t bytes);


void* dbus_realloc       (void  *memory,
                          size_t bytes);

void  dbus_free          (void  *memory);



void dbus_free_string_array (char **str_array);

typedef void (* DBusFreeFunction) (void *memory);


void dbus_shutdown (void);
]]

--[[
local function dbus_new(type, count)  
	return ((type*)dbus_malloc (ffi.sizeof (type) * (count)))
end

local function dbus_new0(type, count) 
	return ((type*)dbus_malloc0 (ffi.sizeof (type) * (count)))
end
--]]