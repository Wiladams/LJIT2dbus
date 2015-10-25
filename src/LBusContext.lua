--DBusContext.lua
local ffi = require("ffi")
local dbus = require("dbus")

local DBusContext = {}

function DBusContext.localMachineId(self)
	local str = dbus.dbus_get_local_machine_id();
	if str == nil then return nil; end

	return ffi.string(str);
end

function DBusContext.version(self)
	local major = ffi.new("int[1]")
	local minor = ffi.new("int[1]")
	local micro = ffi.new("int[1]")
	dbus.dbus_get_version(major, minor, micro)
	ver = {Major=major[0], Minor=minor[0], Micro=micro[0]}
	setmetatable(ver, {
		__tostring=function(self)
			return string.format("%d.%d.%d", self.Major, self.Minor, self.Micro)
		end,
	})
	
	return ver
end

return DBusContext
