local filesystem = require("filesystem")

function directoryExists(path)
    return filesystem.exists(path) and filesystem.isDirectory(path)
end

function randomString(length)
    local res = ""
    for i = 1, length do
        res = res .. string.char(math.random(97, 122))
    end
    return res
end

function printFile(filename)
    local file = io.open(filename, "r")
    if file then
        for line in file:lines() do
            print(line)
        end
        file:close()
    else
        print("Error reading file: " .. filename)
        os.exit(84)
    end
end
