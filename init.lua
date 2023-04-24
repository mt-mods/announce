announce = {}

local http = minetest.request_http_api()
if not http then
    minetest.log("warning", "[announce-mod] can't use the http functions, aborting")
    return
end

local MP = minetest.get_modpath("announce")
dofile(MP .. "/proto.lua")
loadfile(MP.."/announce.lua")(http)
dofile(MP .. "/serialize_json.lua")
dofile(MP .. "/lifecycle.lua")

if minetest.get_modpath("mtt") and mtt.enabled then
    dofile(MP .. "/proto.spec.lua")
    dofile(MP .. "/serialize_json.spec.lua")
end