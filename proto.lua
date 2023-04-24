
-- dirty hack to get server proto versions, relies currently on the `minetest.features` table
function announce.get_proto()
    if minetest.features.compress_zstd then
        -- 5.7.x
        return 37, 42
    elseif minetest.features.get_sky_as_table then
        -- 5.6.x
        return 37, 41
    elseif minetest.features.dynamic_add_media_table then
        -- 5.5.x
        return 37, 40
    elseif minetest.features.use_texture_alpha_string_modes then
        -- 5.4.x
        return 37, 39
    elseif minetest.features.object_step_has_moveresult then
        -- 5.3.x
        return 37, 39
    elseif minetest.features.pathfinder_works then
        -- 5.2.x
        return 37, 39
    elseif minetest.features.area_store_persistent_ids then
        -- 5.1.x
        return 37, 38
    elseif minetest.features.object_independent_selectionbox then
        -- 5.0.x
        return 37, 37
    end
end