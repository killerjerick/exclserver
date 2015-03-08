local PLUGIN=ES.Plugin()
PLUGIN:SetInfo("Announce","Announce messages to all players.","Excl")

PLUGIN:AddFlag(EXCL_PLUGIN_FLAG_NODEFAULTDISABLED)
PLUGIN:AddFlag(EXCL_PLUGIN_FLAG_NOCANDISABLE)

if SERVER then
	PLUGIN:AddCommand("announce",function(p,a)
		if IsValid(p) or type(a[1]) ~= "string" then return end

		ES.ChatBroadcast("<hl>(ANNOUNCEMENT)</hl> "..(table.concat(a," ",1) or ""))

	end,20)
end
PLUGIN()
