-- This file is for x86_64
-- a different one might be required for other platforms

local ffi = require("ffi")
local bit = require("bit")
local lshift, rshift, band, bor = bit.lshift, bit.rshift, bit.band, bit.bor

--require ("dbus-macros")

C = {}	-- Constants
Types = {}	-- Types

Types.int64_t = ffi.typeof("int64_t")
Types.uint64_t = ffi.typeof("uint64_t")

C.DBUS_HAVE_INT64 = true;

ffi.cdef[[
typedef uint32_t dbus_uint32_t;
typedef int32_t dbus_int32_t;
typedef uint16_t dbus_uint16_t;
typedef int16_t dbus_int16_t;
typedef int64_t dbus_int64_t;
typedef uint64_t dbus_uint64_t;
]]


ffi.cdef[[
typedef int dbus_int32_t;
typedef unsigned int dbus_uint32_t;

typedef short dbus_int16_t;
typedef unsigned short dbus_uint16_t;
]]

local function DBUS_INT64_CONSTANT(x) return Types.int64_t(x) end
local function DBUS_UINT64_CONSTANT(x) return Types.uint64_t(x) end


C.DBUS_MAJOR_VERSION = 1
C.DBUS_MINOR_VERSION = 8
C.DBUS_MICRO_VERSION = 12

C.DBUS_VERSION_STRING = "1.8.12"

C.DBUS_VERSION = bor(lshift(1, 16), lshift(8, 8), (12)) 


local exports = {}
setmetatable(exports, {

})

return exports