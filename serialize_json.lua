
-- simple json serializer
-- NOTE: this would not be needed in a perfect world :/
-- this works around the quirks of the builtin `minetest.write_json`
-- namely: fractional numbers for integer values and empty tables as nil
function announce.serialize_json(data)
    if type(data) == "nil" then
        return "null"
    elseif type(data) == "boolean" then
        return data and "true" or "false"
    elseif type(data) == "string" then
        return "\"" .. data .. "\""
    elseif type(data) == "number" then
        return "" .. data
    elseif type(data) == "table" then
        if data[1] or next(data) == nil then
            -- array or empty table
            local str = ""
            for i, v in ipairs(data) do
                str = str .. announce.serialize_json(v)
                if i < #data then
                    str = str .. ","
                end
            end
            return "[" .. str .. "]"
        else
            -- object
            local str = ""
            for k, v in pairs(data) do
                str = str .. announce.serialize_json(k) .. ":" .. announce.serialize_json(v) .. ","
            end
            -- remove trailing comma
            str = str:sub(1, #str-1)
            return "{" .. str .. "}"
        end
    end
end