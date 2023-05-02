announce = {
    anonymize_players = minetest.settings:get_bool("announce_anonymize")
}

local http = minetest.request_http_api()
if not http then
    minetest.log("warning", "[announce-mod] can't use the http functions, aborting")
    return
end

local MP = minetest.get_modpath("announce")
dofile(MP .. "/proto.lua")
dofile(MP .. "/multipart.lua")
loadfile(MP.."/announce.lua")(http)
dofile(MP .. "/serialize_json.lua")
dofile(MP .. "/lag.lua")
dofile(MP .. "/lifecycle.lua")

if minetest.get_modpath("mtt") and mtt.enabled then
    dofile(MP .. "/multipart.spec.lua")
    dofile(MP .. "/proto.spec.lua")
    dofile(MP .. "/serialize_json.spec.lua")
end
