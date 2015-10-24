

local function fprintf(fd, fmt, ...)
	fd:write(string.format(fmt, ...));
end

local function printf(fmt, ...)
	fprintf(io.stdout, fmt, ...)
end

local exports = {
	fprintf = fprintf;
	printf = printf;
}

return exports