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

function DBusContext.validatePath(self, path)
	local err = dbus.DBusError();
	local res = dbus.dbus_validate_path(path, err);

	return res == dbus.TRUE;
end

function DBusContext.validateInterface(self, name)
	local err = dbus.DBusError();
	local res = dbus.dbus_validate_interface(name, err);

	return res == dbus.TRUE;
end

function DBusContext.validateMember(self, name)
	local err = dbus.DBusError();
	local res = dbus.dbus_validate_member(name, err);

	return res == dbus.TRUE;
end

function DBusContext.validateErrorName(self, name)
	local err = dbus.DBusError();
	local res = dbus.dbus_validate_error_name(name, err);

	return res == dbus.TRUE;
end

function DBusContext.validateBusName(self, name)
	local err = dbus.DBusError();
	local res = dbus.dbus_validate_bus_name(name, err);

	return res == dbus.TRUE;
end

function DBusContext.validateUtf8(self, alleged_utf8)
	local err = dbus.DBusError();
	local res = dbus.dbus_validate_utf8(alleged_utf8, err);

	return res == dbus.TRUE;
end




return DBusContext
