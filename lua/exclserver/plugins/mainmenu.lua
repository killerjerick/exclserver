-- A bunch of command aliases to open up the main menu. Nothing special here.
if SERVER then
	util.AddNetworkString("ESToggleMenu");
end

PLUGIN:SetInfo("Mainmenu","Opens the ExclServer main menu.","Excl")
PLUGIN:AddCommand("shop",function(p,a)
	net.Start("ESToggleMenu"); net.Send(p);
end);
PLUGIN:AddCommand("mainmenu",function(p,a)
	net.Start("ESToggleMenu"); net.Send(p);
end);
PLUGIN:AddCommand("menu",function(p,a)
	net.Start("ESToggleMenu"); net.Send(p);
end);
PLUGIN:AddCommand("excl",function(p,a)
	net.Start("ESToggleMenu"); net.Send(p);
end);
PLUGIN:AddCommand("exclserver",function(p,a)
	net.Start("ESToggleMenu"); net.Send(p);
end);
PLUGIN:AddCommand("store",function(p,a)
	net.Start("ESToggleMenu"); net.Send(p);
end);
PLUGIN:AddCommand("motd",function(p,a)
	p:SendLua("ES:ToggleMotd()");
end);
PLUGIN:AddCommand("rules",function(p,a)
	p:SendLua("ES:ToggleMotd()");
end);
PLUGIN:AddFlag(EXCL_PLUGIN_FLAG_NODEFAULTDISABLED)
PLUGIN:AddFlag(EXCL_PLUGIN_FLAG_NOCANDISABLE)