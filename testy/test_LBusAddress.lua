package.path = package.path..";../src/?.lua"

local LBusAddress = require("LBusAddress")

for _, addr in LBusAddress.parseAddresses("tcp:host=example.com,port=8073;udp:host=localhost,port=8080") do
	print("method: ", addr:method(), "port:", addr:value("port"))
end