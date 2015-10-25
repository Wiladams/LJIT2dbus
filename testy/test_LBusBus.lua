package.path = package.path..";../src/?.lua"


local LBusContext = require("LBusContext")
local LBusBus = require("LBusBus")
local dbus = require("dbus")

local bus = LBusBus();
print("        Bus: ", bus)
print("Unique Name: ", bus:uniqueName())

print("flushing: ", bus, bus.Handle)
bus:flush();

