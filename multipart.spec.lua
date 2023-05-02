
mtt.register("multipart", function(callback)
    local mp = announce.multipart()
    mp.add("xy", "1234")
    assert(mp.contentType())
    assert(mp.boundary())

    local str = mp.serialize()
    assert(str)

    callback()
end)