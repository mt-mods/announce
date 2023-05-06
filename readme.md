Minetest server-announce mod

![](https://github.com/mt-mods/announce/workflows/luacheck/badge.svg)
![](https://github.com/mt-mods/announce/workflows/test/badge.svg)
[![License](https://img.shields.io/badge/License-MIT%20and%20CC%20BY--SA%203.0-green.svg)](license.txt)
[![Download](https://img.shields.io/badge/Download-ContentDB-blue.svg)](https://content.minetest.net/packages/mt-mods/announce)

# Features

* Announcing the server to the serverlist
* Player-anonymization (if the `announce_anonymize` setting is `true`)
* Multi-announce

# Shortcomings (minetest <= `5.7.0`)

The engine doesn't expose the supported protocol versions in <= `5.7.0`
and the mod tries to guess the min- and max-values as best as possible
depending on the `minetest.features` table.

# Setting up

Install the mod and configure its settings:

**NOTE:** the `server_announce` setting is unused

For a simple single-serverlist announcement with anonymization:
```
# default setting, required
serverlist_url = https://servers.minetest.net
# needed to access the serverlist
secure.http_mods = announce
# anonymize setting
announce_anonymize = true
```

Multiple serverlists:
```
serverlist_url = https://servers.minetest.net,https://my.server.list
secure.http_mods = announce
```

# License

MIT