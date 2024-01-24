local utils = require("utils")
local baseRepo = "https://raw.githubusercontent.com/M4NIK0/AE2-OC/main/"
local downloadPath = "/home/manager"

function downloadFileFromRepo(filename, tmpFolder)
    local url = baseRepo .. filename
    local tmpPath = "/tmp/" .. tmpFolder .. "/" .. filename

    local command = "wget " .. url .. " -O " .. tmpPath
    local exitCode = os.execute(command)

    if exitCode == 0 then
        print("Downloaded:", filename)
    else
        print("Failed to download:", filename)
        print("Stopping update.")
        os.exit(84)
    end
end

function downloadFilesFromRepo(tmpFolder)
    os.execute("mkdir -p /tmp/" .. tmpFolder)
    downloadFileFromRepo("dependencies.txt", tmpFolder)

    local file = io.open("/tmp/" .. tmpFolder .. "/dependencies.txt", "r")
    if file then
        for line in file:lines() do
            downloadFileFromRepo(line, tmpFolder)
        end
        file:close()
    else
        print("Failed to open dependencies.txt")
    end
    os.execute("rm -rf " .. downloadPath)
    os.execute("cp -r " .. tmpFolder .. " " .. downloadPath)
    os.execute("rm -rf /tmp/" .. tmpFolder)
end

downloadFilesFromRepo(utils.randomString(16))
