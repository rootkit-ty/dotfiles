pcall(require, "luarocks.loader")
-- Make sue you have this installed (awesome wants lua 5.3)
-- luarocks install luasockets --local --lua-ver 5.3
local http = require("socket.http")
-- luarocks install htmlparser --local --lua-ver 5.3
local htmlparser = require("htmlparser")

-- Awesome utils
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")


maildirWidget = wibox.widget.textbox()

-- Call notmuch every 60 seconds to ensure that the count is correct
local slow_mail_timer = gears.timer({ timeout = 60, call_now = true, auto_start = true, callback = function ()

	-- Notmuch to the rescue
	local f = io.popen('notmuch count tag:unread')
	for line in f:lines() do maildirWidget:set_text(":" .. line) end
	f:close()

end})

--- Notification with weather information. Popups when mouse hovers over the icon
local notification
maildirWidget:connect_signal("mouse::enter", function()

	local content = ''
	-- This is ungodly, but does what I need while being fast
	-- local f = io.popen("fd -t f . " .. MAIL_DIR .. " | rg -v ',[^,]*S[^,]*$' | xargs rg '^Date: ' --vimgrep --no-column -N | awk '{split($0,a,\":Date:\"); print a[2],\"|\",a[1]}' | sort | tail -n-1 | awk '{print $8}' | xargs grep -Po '(From: .*$|Subject: .*$)'")
	local f = io.popen("notmuch search --format json tag:unread | head -n1 | rg -o '\"authors\": \"(.*?)\", \"subject\": \"(.*?)\"' -r 'From:$1\nSubject:$2'")
	for line in f:lines() do content = content.. line ..'\n'end
	f:close()
    notification = naughty.notify{
        --icon = path_to_icons .. icon_map[resp.weather[1].icon],
		-- icon_size=20,
        text = content,
        timeout = 5, hover_timeout = 10,
        width = 500
    }
end)

maildirWidget:connect_signal("mouse::leave", function()
    naughty.destroy(notification)
end)

slow_mail_timer:start()

maildirWidget.font = "Sauce Code Pro NF 14"
return maildirWidget
