-- LBusMessage.lua
local dbus = require("dbus")

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

return LBusMessage;
