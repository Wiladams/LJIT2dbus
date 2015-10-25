-- LBusConnection.lua

local dbus = require("dbus")

LBusConnection = {}
setmetatable(LBusConnection, {
	__call = function(self, ...)
		return self:new(...);
	end,
})

LBusConnection_mt = {
	__index = LBusConnection;
}

function LBusConnection.init(self, handle)
	local obj = {
		Handle = handle;
	}
	setmetatable(obj, LBusConnection_mt);

	return obj;
end

function LBusConnection.new(self, address)
	local err = dbus.DBusError();
	local conn = dbus.dbus_connection_open(address,err);

	return self:init(conn);
end

function LBusConnection.flush(self)
	dbus.dbus_connection_flush(self.Handle);
end

function LBusConnection.send(self, msg, client_serial)
    local res = dbus.dbus_connection_send(self.Handle, msg.Handle, client_serial)

	return res == dbus.TRUE;
end

return LBusConnection;
