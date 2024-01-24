local utils = require("utils")

utils.readFile("banner")
print("Manager Started")
print("Checking for Update")
dofile("autoUpdate.lua")