pcall(require, "luarocks.loader")
-- Make sue you have this installed (awesome wants lua 5.3)
-- luarocks install luasockets --local --lua-ver 5.3
local http = require("socket.http")
-- luarocks install htmlparser --local --lua-ver 5.3
local htmlparser = require("htmlparser")

-- TODO: Actually parse this for icons ftp://ftp.bom.gov.au/anon/gen/fwo/IDV10450.xml
-- http://reg.bom.gov.au/info/forecast_icons.shtml
-- Nerd Fonts has some good weather icons

-- Awesome utils
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

bomWidget = wibox.widget.textbox()

bomWidget:connect_signal("button::press", function (widget, lx, ly, button, mods, find_widgets_result) 
	local name_match_rule = { '@cgDISVMf:- | Melbourne Weather', '', '@cgDISVMf:- | Melbourne Rain Radar' }

	-- Find clients matching either '@cgDISVMf:- | Melbourne Weather' for left mouse
	-- or '@cgDISVMf:- | Melbourne Rain Radar' for right mouse
	for c in awful.client.iterate(function (c) return awful.rules.match(c, {name = name_match_rule[button]})end) do

		-- Toggle their hidden status
		c.hidden = not c.hidden
		-- Move them to current tag
		c:tags({mouse.screen.selected_tag})

		-- Place it on the top right
		awful.placement.top_right(c, { margins = {top = 25, right = 10},
			parent = awful.screen.focused() })
	end

	-- Find the other client and hide it
	for c in awful.client.iterate(function (c) return awful.rules.match(c, {name = name_match_rule[(button + 2) % 4]})end) do
		c.hidden = true
	end
end)

-- Spawn surf for full weather info
awful.spawn.single_instance('surf -Kb http://m.bom.gov.au/vic/melbourne/', {
		width = "300",
		height = "600",
		screen = awful.screen.focused(),
		titlebars_enabled = false,
		skip_taskbar= true,
		urgent = false,
		ontop = true,
		-- placement = awful.placement.closest_corner,
		hidden = true,
		floating = true,
		callback = function(c) gears.timer.delayed_call(function() c.urgent = false end) end
	})

-- Spawn surf for rain radar
awful.spawn.single_instance('surf -Kb http://m.bom.gov.au/vic/melbourne/radar/', {
		width = "300",
		height = "600",
		screen = awful.screen.focused(),
		titlebars_enabled = false,
		skip_taskbar= true,
		urgent = false,
		ontop = true,
		hidden = true,
		floating = true,
		callback = function(c) gears.timer.delayed_call(function() c.urgent = false end) end
	})

-- Run every 5 minutes
local weather_timer = gears.timer({ timeout = 300 })
weather_timer:connect_signal("timeout", function ()

	-- This is hardcoded to get melbourne olympic park
	-- change the station to check copy the raw URL for the station
	url = "http://reg.bom.gov.au/products/IDV60901/IDV60901.95936.shtml"

	body, status = http.request(url)


	-- Make sure it's valid
	if (status == 200 ) then
		-- Practically ignore HTML errors
		-- because BOM can't produce valid HTML to save their life
		local root = htmlparser.parse(body, 500)

		-- Get the most recent observation for melbourne
		local cur_obs = root("tr.rowleftcolumn")[1]

		if cur_obs == nil then
			return
		end

		-- Derrive useful data from HTML
		-- I don't care if it's 20, only if it feels like it.
		local app_tmp = cur_obs("[headers~='t1-apptmp']")[1]:getcontent()
		--local act_tmp = cur_obs("[headers~='t1-tmp']")[1]:getcontent()
		--local cur_tim = cur_obs("[headers~='t1-datetime']")[1]:getcontent()

		-- If you want freedom units, add them yourself
		bomWidget:set_text(app_tmp .. "C")
	end
end)

weather_timer:start()
weather_timer:emit_signal("timeout")

bomWidget.font = "Sauce Code Pro NF 14"
-- Return the widget
return bomWidget
