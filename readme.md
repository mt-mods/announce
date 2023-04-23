

```sh
docker-compose exec minetest sh
```

```sh
json='{
    "action":"start",
    "port":30000,
    "address":"minetest",
    "name":"testserver",
    "description":"desc",
    "version":"1.2.3-xy",
    "proto_min": 39,
    "proto_max": 40,
    "url": "http://minetest:8080",
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
    "privs":"shout",
    "can_see_far_names":false,
    "mods":["default"]
}'
curl -v -F "json=${json}" "http://serverlist:8080/announce"
```