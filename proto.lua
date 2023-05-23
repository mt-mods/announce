
-- get server proto versions, falls back to the `minetest.features` table on engine versions prior to 5.8.0
function announce.get_proto()
    local version = minetest.get_version()

    local min, max
    if version.proto_min and version.proto_max then
        -- use engine provided min/max (>=5.8.0)
        min, max = version.proto_min, version.proto_max
    elseif minetest.features.compress_zstd then
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