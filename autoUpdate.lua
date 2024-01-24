local baseRepo = "https://raw.githubusercontent.com/M4NIK0/AE2-OC/main/"
local downloadPath = "/home/manager"

function randomString(length)
    local res = ""
    for i = 1, length do
        res = res .. string.char(math.random(97, 122))
    end
    return res
end

function downloadFileFromRepo(filename, tmpFolder)
    local url = baseRepo .. filename
    local tmpPath = "/tmp/" .. tmpFolder .. "/" .. filename

    os.execute("wget " .. url .. " " .. tmpPath)

    print("Downloaded:", filename)
end

function downloadFilesFromRepo(tmpFolder)
    os.execute("mkdir /tmp/" .. tmpFolder)
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

    os.execute("rm -rf /tmp/" .. tmpFolder)
end

downloadFilesFromRepo(randomString(16))