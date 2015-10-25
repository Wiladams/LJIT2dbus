local ffi = require("ffi")

local function fprintf(fd, fmt, ...)
	fd:write(string.format(fmt, ...));
end

local function printf(fmt, ...)
	fprintf(io.stdout, fmt, ...)
end

ffi.cdef[[
char *strdup (const char *);
]]

local exports = {
	fprintf = fprintf;
	printf = printf;
	strdup = ffi.C.strdup;
}

return exports