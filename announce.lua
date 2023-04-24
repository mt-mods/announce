local http = ...

local function fill_start_update_fields(data)
    data.port = minetest.settings:get("port")
    data.address = minetest.settings:get("server_address")
    data.name = minetest.settings:get("server_name")
    data.description = minetest.settings:get("server_description")

    local version = minetest.get_version()
    data.version = version.string

    data.proto_min, data.proto_max = announce.get_proto()

    data.url = minetest.settings:get("server_url")
    data.creative = minetest.settings:get_bool("creative_mode")
    data.damage = minetest.settings:get_bool("enable_damage")
    data.password = minetest.settings:get_bool("disallow_empty_password")
    data.pvp = minetest.settings:get_bool("enable_pvp")
    data.uptime = minetest.get_server_uptime()
    data.game_time = minetest.get_gametime()

    local players = minetest.get_connected_players()
    data.clients = #players
    data.clients_max = tonumber(minetest.settings:get("max_users"))
    data.clients_list = {}
    for _, player in ipairs(players) do
        table.insert(data.clients_list, player:get_player_name())
    end

    local game_info = minetest.get_game_info()
    data.gameid = game_info.id
end

function announce.announce_start()
    minetest.log("info", "[announce-mod] announce_start()")
    local data = {
        action = "start",
        dedicated = true,
        rollback = minetest.settings:get_bool("enable_rollback_recording"),
        mapgen = minetest.get_mapgen_setting("mg_name"),
        privs = minetest.settings:get("default_privs"),
        can_see_far_names = tonumber(minetest.settings:get("player_transfer_distance")) <= 0,
        mods = {"default"} -- minetest.get_modnames()
    }

    fill_start_update_fields(data)

    local json = minetest.write_json(data)
    -- replace nulled client-list
    json = json:gsub("\"clients_list\":null", "\"clients_list\":[]")

    local boundary = "" .. (math.random() * 10000)
    local post_data = "--" .. boundary .. "\r\nContent-Disposition: form-data; name=\"json\"\r\n\r\n" ..
        json .. "\r\n" ..
        "--" .. boundary .. "--\r\n"
    print(post_data)

    http.fetch({
        url = minetest.settings:get("serverlist_url") .. "/announce",
        timeout = 30,
        extra_headers = {
            "Content-Type: multipart/form-data; boundary=" .. boundary
        },
        data = post_data,
        method = "POST"
    }, function(res)
        print(dump({
            res = res
        }))
        -- TODO
    end)
end

minetest.after(1, function()
    announce.announce_start()
end)