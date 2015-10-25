package.path = package.path..";../src/?.lua"

local LBusMessage = require("LBusMessage")

local SYSNOTE_NAME  ="org.freedesktop.Notifications"
local SYSNOTE_OPATH ="/org/freedesktop/Notifications"
local SYSNOTE_IFACE ="org.freedesktop.Notifications"
local SYSNOTE_NOTE  ="SystemNoteDialog"


local msg = LBusMessage:newMethodCall(SYSNOTE_NAME, SYSNOTE_OPATH, SYSNOTE_IFACE, SYSNOTE_NOTE);

assert(msg)

print("Appending arguments to the message");
  local dispMsg = "Hello World!";
  local buttonText = "";
  local iconType = 1;

assert(msg:addArg(dispMsg));
assert(msg:addArg(buttonText));
assert(msg:addArg(iconType));


print("     path: ", msg:path())
print("interface: ", msg:interface())

print("== ARGS ==")
for _, anArg in msg:args() do 
	print(string.format('%s',anArg))
end

