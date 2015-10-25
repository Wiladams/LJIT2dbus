package.path = package.path..";../src/?.lua"


local LBusContext = require("LBusContext")

print("     LBusContext:version(): ", LBusContext:version())
print("LBusContext:localMachineId: ", LBusContext:localMachineId())

