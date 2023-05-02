local CRLF = "\r\n"

function announce.multipart()
    local parts = {}
    local boundary = "" .. (math.random() * 10000)

    return {
        add = function(name, data)
            table.insert(parts, {
                name = name,
                data = data
            })
        end,

        boundary = function()
            return boundary
        end,

        contentType = function()
            return "multipart/form-data; boundary=" .. boundary
        end,

        serialize = function()
            local str = ""

            for _, part in ipairs(parts) do
                str = str .. "--" .. boundary .. CRLF
                str = str .. "Content-Disposition: form-data; name=\"" .. part.name .. "\"" .. CRLF
                str = str .. CRLF
                str = str .. part.data
                str = str .. CRLF
            end
            str = str .. "--" .. boundary .. "--" .. CRLF

            return str
        end
    }
end