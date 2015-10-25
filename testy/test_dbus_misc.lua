package.path = package.path..";../src/?.lua"

local ffi = require("ffi")
local dbus = require("dbus")

local function getLocalMachineId()
	local str = dbus.dbus_get_local_machine_id();
	return ffi.string(str);
end

local function getVersion()
	local major = ffi.new("int[1]")
	local minor = ffi.new("int[1]")
	local micro = ffi.new("int[1]")
	dbus.dbus_get_version(major, minor, micro)
	return {Major=major[0], Minor=minor[0], Micro=micro[0]}
end

local function printVersion(ver)
	print(string.format("%d.%d.%d", ver.Major, ver.Minor, ver.Micro))
end

local ver = getVersion();
printVersion(ver)
print("Machine ID: ", getLocalMachineId())

print ("DBusError: ", dbus.DBusError)
print("Instance: ", dbus.DBusError())