-- for messages that are used a lot, why keep making hooks for them? annoying as fuck.

--When a certain command can only be used on one player
net.Receive("ESCmdOnlyOne",function()
	chat.AddText("error",Color(255,255,255),"This command can only be ran on one player at a time, specify only one player!")
end)

net.Receive("ESTriedRun",function()

	local runner = net.ReadEntity()
	local victim = net.ReadString()
	local command = net.ReadString()

	chat.AddText("accessdenied",

		Color(255,255,255), exclFixCaps(runner:ESGetRank().pretty).." ",

		Color(102,255,51 ), runner:Nick(),

		Color(255,255,255),	" tried to "..command.." ",

		Color(102,255,51 ), string.gsub(victim,"^","*"),

		Color(255,255,255),	"."

	)
end)