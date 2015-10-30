package.path = package.path..";../src/?.lua"


local LBusContext = require("LBusContext")

print("     LBusContext:version(): ", LBusContext:version())
print("LBusContext:localMachineId: ", LBusContext:localMachineId())

local function validatePath(path)
	print("validating Path: ", path, LBusContext:validatePath(path));
end

validatePath("/")
validatePath("/foo")
validatePath("/foo/bar")
validatePath("/foo/bar/baz124")
validatePath("/false/path/here/")
