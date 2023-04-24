
-- dirty hack to get server proto versions, relies currently on the `minetest.features` table
function announce.get_proto()
    local min, max

    if minetest.features.compress_zstd then
        -- 5.7.x
        min, max = 37, 42
    elseif minetest.features.get_sky_as_table then
        -- 5.6.x
        min, max = 37, 41
    elseif minetest.features.dynamic_add_media_table then
        -- 5.5.x
        min, max = 37, 40
    elseif minetest.features.use_texture_alpha_string_modes then
        -- 5.4.x
        min, max = 37, 39
    elseif minetest.features.object_step_has_moveresult then
        -- 5.3.x
        min, max = 37, 39
    elseif minetest.features.pathfinder_works then
        -- 5.2.x
        min, max = 37, 39
    elseif minetest.features.area_store_persistent_ids then
        -- 5.1.x
        min, max = 37, 38
    elseif minetest.features.object_independent_selectionbox then
        -- 5.0.x
        min, max = 37, 37
    end

    if minetest.settings:get_bool("strict_protocol_version_checking") then
        min = max
    end
    return min, max
end