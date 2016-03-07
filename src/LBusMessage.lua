-- LBusMessage.lua
local ffi = require("ffi")
local dbus = require("dbus")
local libc = require("libc")

local int = ffi.typeof("int")


local LBusMessage = {}
setmetatable(LBusMessage, {

})

local LBusMessage_mt = {
	__index = LBusMessage;
}

function LBusMessage.init(self, handle)
	local obj = {
		Handle = handle;
	}
	setmetatable(obj, LBusMessage_mt)

	return obj
end

function LBusMessage.new(self, ...)
	return self:init(...)
end

function LBusMessage.newMethodCall(self, destination, path, interface, method)
	local msg = dbus.dbus_message_new_method_call(destination,
        path,
        interface,
        method);

	if msg == nil then return nil, "error occured" end

	ffi.gc(msg, dbus.dbus_message_unref)

	return self:init(msg);
end

function LBusMessage.setNoreply(self, istrue)
	if istrue then
		dbus.dbus_message_set_no_reply(self.Handle, dbus.TRUE);
	else
		dbus.dbus_message_set_no_reply(self.Handle, dbus.FALSE);
	end		
end

function LBusMessage.addArg(self, argValue, argType)
	local bValue = dbus.DBusBasicValue()
	local bType = nil;

	if type(argValue) == "string" then
		bValue.str = libc.strdup(argValue);
		bType = argType or DBUS_TYPE_STRING;
		--print("LBusMessage.addArg(string): ", argValue, bType)
	elseif type(argValue) == "number" then
		bValue.u32 = argValue;
		bType = argType or DBUS_TYPE_UINT32;
	else
		return false;
	end

	local res = dbus.dbus_message_append_args(self.Handle, bType, bValue, int(DBUS_TYPE_INVALID));

	return res == dbus.TRUE;
end

function LBusMessage.typeOfMessage(self)
	return dbus.dbus_message_get_type(self.Handle);
end

function LBusMessage.path(self, value)
	local res = false;

	if value then
		res = dbus.dbus_message_set_path(self.Handle, value);
		return res == dbus.TRUE;
	end

	local str = dbus.dbus_message_get_path(self.Handle);
	if str == nil then return nil end

	return ffi.string(str)
end

function LBusMessage.interface(self, value)
	local res = false;

	if value then
		res = dbus.dbus_message_set_interface(self.Handle, value);
		return res == dbus.TRUE;
	end

	local str = dbus.dbus_message_get_interface(self.Handle);
	if str == nil then return nil end

	return ffi.string(str)
end

--[[

dbus_bool_t   dbus_message_has_path         (DBusMessage   *message, 
                                             const char    *object_path);  

dbus_bool_t   dbus_message_has_interface    (DBusMessage   *message, 
                                             const char    *iface);

--]]

--[[

dbus_bool_t dbus_message_iter_has_next         (DBusMessageIter *iter);

int         dbus_message_iter_get_arg_type     (DBusMessageIter *iter);

int         dbus_message_iter_get_element_type (DBusMessageIter *iter);

void        dbus_message_iter_recurse          (DBusMessageIter *iter,
                                                DBusMessageIter *sub);
--]]

-- An iterator over the arguments that are currently
-- within the message structure
local function nil_gen()
	return nil;
end

function LBusMessage.args(self)
	local iter = dbus.DBusMessageIter();
	local res = dbus.dbus_message_iter_init(self.Handle, iter);
	if res ~= dbus.TRUE then return nil_gen end


	local function arg_gen(param, hasMore)
		--if dbus.dbus_message_iter_has_next(param) == dbus.FALSE then
		--	return nil;
		--end
		if not hasMore then
			return nil;
		end

		local argType = dbus.dbus_message_iter_get_arg_type(param)
		local value = nil;

		if argType == DBUS_TYPE_STRING then
			local valuep = ffi.new("char *[1]")
			dbus.dbus_message_iter_get_basic(param, valuep);
			if valuep[0] ~= nil then
				value = ffi.string(valuep[0])
			end
		elseif argType == DBUS_TYPE_UINT32 then
			local valuep=ffi.new("uint32_t[1]")
			dbus.dbus_message_iter_get_basic(param, valuep);
			value = valuep[0]
		else
			value = "UNKNOWN TYPE"
		end

		-- move the iterator to the next one before returning
		local res = dbus.dbus_message_iter_next(param);
		hasMore = res == dbus.TRUE

		--print(str, type(value), #value, hasMore)

		return hasMore, value
	end

	return arg_gen, iter, true
end


return LBusMessage;
