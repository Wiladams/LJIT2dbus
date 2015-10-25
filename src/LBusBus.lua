-- LBusBus.lua
local ffi = require("ffi")
local dbus = require("dbus")
local LBusConnection = require("LBusConnection")


local LBusBus = {}
setmetatable(LBusBus, {
	__call = function(self, ...)
		return self:new(...);
	end,

	-- make this a sub-class of LBusConnection
	-- so, any calls that come into an instance, which aren't 
	-- implemented here, will be forwarded to the LBusConnection table
	__index = LBusConnection;	

})
LBusBus_mt = {
	__index = LBusBus;
}

function LBusBus.init(self, handle)
	local obj = {
		Handle = handle;
		--Connection = LBusConnection:init(handle);
	}
	setmetatable(obj, LBusBus_mt);

	return obj;
end

function LBusBus.new(self, bustype)
	bustype = bustype or dbus.DBUS_BUS_SESSION;
	local err = dbus.DBusError();
	dbus.dbus_error_init(err);

	local handle = dbus.dbus_bus_get(bustype, err);
	if handle == nil then return nil end

  	ffi.gc(handle, dbus.dbus_connection_unref);

	return self:init(handle)
end

function LBusBus.newPrivate(self)
	bustype = bustype or dbus.DBUS_BUS_SESSION;
	local err = dbus.DBusError();
	dbus.dbus_error_init(err);

	local handle = dbus.dbus_bus_get_private(bustype, err);

	return self:init(handle)
end

function LBusBus.register(self)
	local err = dbus.DBusError();
	dbus.dbus_error_init(err);

	local res = dbus.dbus_bus_register(self.Handle,err);

	return res == dbus.TRUE;
end

function LBusBus.uniqueName(self, value)
	if value then
		local res = dbus.dbus_bus_set_unique_name(self.Handle,unique_name);
		return res == dbus.TRUE;
	end
	
	local str = dbus.dbus_bus_get_unique_name(self.Handle);
	if str == nil then return nil end

	return ffi.string(str)
end

--[[
unsigned long   dbus_bus_get_unix_user    (DBusConnection *connection,
			                   const char     *name,
                                           DBusError      *error);

char*           dbus_bus_get_id           (DBusConnection *connection,
                                           DBusError      *error);

int             dbus_bus_request_name     (DBusConnection *connection,
					   const char     *name,
					   unsigned int    flags,
					   DBusError      *error);

int             dbus_bus_release_name     (DBusConnection *connection,
					   const char     *name,
					   DBusError      *error);
--]]

function LBusBus.nameHasOwner(self, name)
	local err = dbus.DBusError();
	dbus.dbus_error_init(err);

	local res = dbus.dbus_bus_name_has_owner(self.Handle, name, err);
print("LBusBus.nameHasOwner: ", res);

	return res == dbus.TRUE;
end

--[[
dbus_bool_t     dbus_bus_start_service_by_name (DBusConnection *connection,
                                                const char     *name,
                                                dbus_uint32_t   flags,
                                                dbus_uint32_t  *reply,
                                                DBusError      *error);
--]]

function LBusBus.addMatch(self, rule)
	local err = dbus.DBusError();
	dbus.dbus_error_init(err);

	dbus.dbus_bus_add_match(self.Handle, rule, err);

	return self;
end

function LBusBus.removeMatch(self, rule)
	local err = dbus.DBusError();
	dbus.dbus_error_init(err);

	dbus.dbus_bus_remove_match(self.Handle, rule, err);

	return self;
end

return LBusBus
