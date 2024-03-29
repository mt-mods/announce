local http = ...

-- sends a multipart request to the announce url
local function send_announce_payload(data)
    local json = announce.serialize_json(data)
    local mp = announce.multipart()
    mp.add("json", json)

    local urls = minetest.settings:get("serverlist_url")

    for url in string.gmatch(urls, "[^,]+") do
        http.fetch({
            url = url .. "/announce",
            timeout = 30,
            extra_headers = {
                "Content-Type: " .. mp.contentType()
            },
            data = mp.serialize(),
            method = "POST"
        }, function(res)
            if res.code >= 400 or res.code == 0 then
                minetest.log(
                    "warning",
                    "[announce-mod] Announcing failed for action: '" .. data.action ..
                        "' code: " .. res.code ..
                        " server: '" .. url .. "'"
                )
            end
        end)
    end
end

local function fill_common_fields(data)
    data.port = minetest.settings:get("port")
    data.address = minetest.settings:get("server_address")
end

local function fill_start_update_fields(data)
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
    data.uptime = math.floor(minetest.get_server_uptime())
    data.game_time = minetest.get_gametime()

    local players = minetest.get_connected_players()
    data.clients = #players
    data.clients_max = tonumber(minetest.settings:get("max_users"))
    data.clients_list = {}
    for i, player in ipairs(players) do
        if announce.anonymize_players then
            table.insert(data.clients_list, "anon-" .. i)
        else
            -- use plain names
            table.insert(data.clients_list, player:get_player_name())
        end
    end

    if type(minetest.get_game_info) == "function" then
        local game_info = minetest.get_game_info()
        data.gameid = game_info.id
    else
        data.gameid = "unknown"
    end
end

function announce.announce_start()
    local data = {
        action = "start",
        dedicated = true,
        rollback = minetest.settings:get_bool("enable_rollback_recording"),
        mapgen = minetest.get_mapgen_setting("mg_name"),
        privs = minetest.settings:get("default_privs"),
        can_see_far_names = tonumber(minetest.settings:get("player_transfer_distance")) <= 0,
        mods = minetest.get_modnames()
    }

    fill_common_fields(data)
    fill_start_update_fields(data)
    send_announce_payload(data)
end

function announce.announce_update()
    local data = {
        action = "update",
        lag = announce.get_avg_lag()
    }

    fill_common_fields(data)
    fill_start_update_fields(data)
    send_announce_payload(data)
end

function announce.announce_delete()
    local data = {
        action = "delete"
    }

    fill_common_fields(data)
    send_announce_payload(data)
end
