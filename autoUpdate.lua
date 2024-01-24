local utils = require("utils")
local baseRepo = "https://raw.githubusercontent.com/M4NIK0/AE2-OC/main/"
local downloadPath = "/home/manager"

function checkDownload(tmpFolder)
    local file = io.open("/tmp/" .. tmpFolder .. "/dependencies.txt", "r")
    if file then
        for line in file:lines() do
            local dlfile = io.open("/tmp/" .. tmpFolder .. "/" .. line, "r")
            if file then
                dlfile:close()
            else
                print("ERROR: Downloading " .. line .. " Failed")
                os.exit(84)
            end
        end
        file:close()
    else
        print("Failed to open dependencies.txt")
    end
end

function downloadFileFromRepo(filename, tmpFolder)
    local url = baseRepo .. filename
    local tmpPath = "/tmp/" .. tmpFolder .. "/" .. filename

    local command = "wget " .. url .. " -O " .. tmpPath
    os.execute(command)
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
    checkDownload(tmpFolder)
    os.execute("rm -rf " .. downloadPath)
    os.execute("cp -r /tmp/" .. tmpFolder .. " " .. downloadPath)
    os.execute("rm -rf /tmp/" .. tmpFolder)
end


downloadFilesFromRepo(utils.randomString(16))
