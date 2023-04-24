
mtt.register("get_proto", function(callback)
    local min, max = announce.get_proto()
    assert(min >= 37)
    assert(max >= 37)
    callback()
end)