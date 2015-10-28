-- LBusAddress.lua

local ffi = require("ffi")
local dbus = require("dbus")

--[[

const char *dbus_address_entry_get_value  (DBusAddressEntry   *entry,
					   const char         *key);

const char *dbus_address_entry_get_method (DBusAddressEntry   *entry);

void        dbus_address_entries_free     (DBusAddressEntry  **entries);


char* dbus_address_escape_value   (const char *value);

char* dbus_address_unescape_value (const char *value,
                                   DBusError  *error);
--]]

local LBusAddress = {}
setmetatable(LBusAddress, {
	__call = function(self, ...)
		return self:new(...);
	end,
})
local LBusAddress_mt = {
	__index = LBusAddress;
}

function LBusAddress.init(self, handle)
	local obj = {
		Handle = handle;
	}
	setmetatable(obj, LBusAddress_mt)

	return obj;
end

function LBusAddress.method(self)
	local str = dbus.dbus_address_entry_get_method(self.Handle)
	if str == nil then return nil end

	return ffi.string(str)
end

function LBusAddress.value(self, key)
	local str = dbus.dbus_address_entry_get_value(self.Handle, key);
	if str == nil then return nil end

	return ffi.string(str);
end

local function nil_gen()
	return nil;
end

function LBusAddress.parsedAddresses(self, str)
	local entry = ffi.new("DBusAddressEntry **[1]")
	local array_len = ffi.new("int [1]")
	local err = dbus.DBusError();

	local res = dbus.dbus_parse_address(str, entry, array_len, err);
	if res ~= dbus.TRUE then
		return nil_gen;
	end

	array_len = array_len[0]
	entry = entry[0];
	ffi.gc(entry, dbus.dbus_address_entries_free)
	
	local function addr_gen(param, state)
		if state >= array_len then
			return nil;
		end

		return state+1, LBusAddress:init(entry[state])
	end

	return addr_gen, entry, 0
end

return LBusAddress
