-- average lag in seconds
local avg_lag = tonumber(minetest.settings:get("dedicated_server_step"))

local last_step = minetest.get_us_time()

-- mimic the behavior of "m_lag_gauge" in `server.cpp`
minetest.register_globalstep(function()
	local now = minetest.get_us_time()
	local dtime = (now - last_step) / 1000000
	last_step = now

	if avg_lag > dtime then
        -- decrease slowly
		avg_lag = dtime - (dtime/100)
    else
        -- increase slowly
        avg_lag = avg_lag + (dtime/100)
	end
end)

function announce.get_avg_lag()
	return avg_lag
end
