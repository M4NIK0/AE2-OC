local utils = require("utils")

utils.printFile("banner")
print("Manager Started")
print("Checking for Update")
dofile("autoUpdate.lua")
print("Update done.")