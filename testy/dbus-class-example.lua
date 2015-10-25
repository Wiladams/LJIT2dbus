package.path = package.path..";../src/?.lua"

--[[
  http://maemo.org/maemo_training_material/maemo4.x/html/maemo_Platform_Development_Chinook/APPENDIX_A_Source_code_for_the_libdbus_example.html

 * A simple D-Bus RPC sending example.
 *
 * This maemo code example is licensed under a MIT-style license,
 * that can be found in the file called "License" in the same
 * directory as this file.
 * Copyright (c) 2007 Nokia Corporation. All rights reserved.
 *
 * The program will:
 * 1) Connect to the D-Bus Session bus
 * 2) Send one RPC method call (one that will cause a Note dialog to
 *    be popped up for user).
 * 3) Quit
--]]

--[[
 * Uses the low-level libdbus which shouldn't be used directly.
 * As the D-Bus API reference puts it "If you use this low-level API
 * directly, you're signing up for some pain".
--]]

local ffi = require("ffi")
local dbus = require("dbus") -- Pull in all of D-Bus headers.
local libc = require("libc")
local printf = libc.printf;
local fprintf = libc.fprintf;
--#include <stdlib.h>    /* EXIT_FAILURE, EXIT_SUCCESS */


local LBusBus = require("LBusBus")
local LBusMessage = require("LBusMessage")


--[[ Symbolic defines for the D-Bus well-known name, interface, object
   path and method name that we're going to use. --]]

local SYSNOTE_NAME  ="org.freedesktop.Notifications"
local SYSNOTE_OPATH ="/org/freedesktop/Notifications"
local SYSNOTE_IFACE ="org.freedesktop.Notifications"
local SYSNOTE_NOTE  ="SystemNoteDialog"

local EXIT_FAILURE = -1;
local EXIT_SUCCESS = 0;
local stderr = io.stderr;

local exit = error;


--[[
 * Utility to terminate if given DBusError is set.
 * Will print out the message and error before terminating.
 *
 * If error is not set, will do nothing.
 *
 * NOTE: In real applications you should spend a moment or two
 *       thinking about the exit-paths from your application and
 *       whether you need to close/unreference all resources that you
 *       have allocated. In this program, we rely on the kernel to do
 *       all necessary cleanup (closing sockets, releasing memory),
 *       but in real life you need to be more careful.
 *
 *       One possible solution model to this is implemented in
 *       "flashlight", a simple program that is presented later.
--]]

local function terminateOnError(msg, err) 

  assert(msg ~= nil);
  assert(error ~= nil);

  if (dbus.dbus_error_is_set(err) ~= 0) then
    fprintf(stderr, msg);
    fprintf(stderr, "DBusError.name: %s\n", error.name);
    fprintf(stderr, "DBusError.message: %s\n", error.message);
    --[[ If the program wouldn't exit because of the error, freeing the
       DBusError needs to be done (with dbus_error_free(error)).
       NOTE:
         dbus_error_free(error) would only free the error if it was
         set, so it is safe to use even when you're unsure. --]]
    exit(EXIT_FAILURE);
  end
end

--[[
 * The main program that demonstrates a simple "fire & forget" RPC
 * method invocation.
--]]
local function main(argc, argv)


  -- Message to display.
  local dispMsg = "Hello World!";
  --local dispMsg = ffi.new("char *[1]", libc.strdup("Hello World!"));
  --local dispMsg = libc.strdup("Hello World!");

  -- Text to use for the acknowledgement button. "" means default.
  local  buttonText = "";
  --local buttonText = ffi.new("char *[1]", libc.strdup(""));
  --local buttonText = libc.strdup("");


  --local iconType = ffi.new("int[1]", 1)
  local iconType = 1;

  local err = dbus.DBusError();
  dbus.dbus_error_init(err);

  printf("Connecting to Session D-Bus\n");
  local bus, err = LBusBus(dbus.DBUS_BUS_SESSION);
  assert(bus ~= nil);

  printf("Checking whether the target name exists ("..SYSNOTE_NAME..")\n");
  
  if not bus:nameHasOwner(SYSNOTE_NAME) then
    fprintf(stderr, "Name has no owner on the bus!\n");
    return EXIT_FAILURE;
  end
  
  --terminateOnError("Failed to check for name ownership\n", err);

  printf("Creating a message object\n");
  local msg = LBusMessage:newMethodCall(SYSNOTE_NAME, SYSNOTE_OPATH, SYSNOTE_IFACE, SYSNOTE_NOTE);
--[[
  local msg = dbus.dbus_message_new_method_call(SYSNOTE_NAME, -- destination
                                     SYSNOTE_OPATH,  -- obj. path
                                     SYSNOTE_IFACE,  -- interface
                                     SYSNOTE_NOTE); -- method str
--]]
  if (msg == nil) then
    fprintf(stderr, "Ran out of memory when creating a message\n");
    error(EXIT_FAILURE);
  end

  msg:setNoreply(true)

  printf("Appending arguments to the message\n");
  assert(msg:addArg(dispMsg));
  assert(msg:addArg(buttonText));
  assert(msg:addArg(iconType));
  assert(msg:finishArgs());

  printf("Adding message to client's send-queue\n");

  if not bus:send(msg, nil) then
    fprintf(stderr, "Ran out of memory while queueing message\n");
    exit(EXIT_FAILURE);
  end

  printf("Waiting for send-queue to be sent out\n");
  bus:flush();

  printf("Queue is now empty\n");
  printf("Cleaning up\n");

  printf("Quitting (success)\n");

  return true;
end

main(#arg, arg)
