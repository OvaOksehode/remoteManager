local serverid = 0

while true do
    local sender, message = rednet.receive()
    if sender == 0 then
        if message == "ping" then
            rednet.send(serverid, textutils.serialiseJSON(fs.list("/remote")))
        else
            message = textutils.unserialiseJSON(message)
            print(type(message["arguments"]))
            print(message["command"])
            if message["arguments"] == nil then
                shell.run("/remote/"..message["command"])
            else
                shell.run("/remote/"..message["command"], unpack(message["arguments"]))
            end
        end
        
    end
end
