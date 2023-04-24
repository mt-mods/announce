Minetest server-announce mod

![](https://github.com/mt-mods/announce/workflows/luacheck/badge.svg)
![](https://github.com/mt-mods/announce/workflows/test/badge.svg)
[![License](https://img.shields.io/badge/License-MIT%20and%20CC%20BY--SA%203.0-green.svg)](license.txt)
[![Download](https://img.shields.io/badge/Download-ContentDB-blue.svg)](https://content.minetest.net/packages/mt-mods/announce)

# Features

* Announcing the server to the serverlist
* Player-anonymization (if the `announce_anonymize` setting is `true`)

Planned features
* Multi-announce

# Shortcomings

The engine doesn't currently expose the supported protocol versions
and the mod tries to guess the min- and max-values as best as possible
depending on the `minetest.features` table.

# Setting up

Install the mod and configure its settings:

```
# default setting, required
serverlist_url = http://serverlist:8080
# this setting is **not** used, the mod is always active
server_announce = true
# needed to access the serverlist
secure.http_mods = announce
# anonymize setting
announce_anonymize = true
```

# License

MIT