
```sh
json='{
    "action":"start",
    "port":30000,
    "address":"127.0.0.1",
    "name":"testserver",
    "description":"desc",
    "version":"1.2.3-xy",
    "proto_min": 39,
    "proto_max": 40,
    "url": "http://localhost:8080",
    "creative": false,
    "damage": false,
    "password": true,
    "pvp": false,
    "uptime": 1,
    "game_time": 100,
    "gameid":"mygame",
    "clients": 0,
    "clients_max": 20,
    "clients_list": [],
    "dedicated":true,
    "rollback":false,
    "mapgen":"v7",
    "privs":["shout"],
    "can_see_far_names":false,
    "mods":["default"]
}'
curl -v -F "json=${json}" "http://127.0.0.1:8080/announce"
```