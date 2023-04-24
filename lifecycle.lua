
-- start
minetest.after(1, announce.announce_start)

-- update
local function announce_loop()
    announce.announce_update()
    minetest.after(30, announce_loop)
end
minetest.after(30, announce_loop)

-- delete
minetest.register_on_shutdown(announce.announce_delete)