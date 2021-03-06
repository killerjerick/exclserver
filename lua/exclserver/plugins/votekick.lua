-- votekick
-- kick off people

local PLUGIN=ES.Plugin()
PLUGIN:SetInfo("Vote kick","Create a vote to kick a certain user from the server.","Excl")
PLUGIN:AddFlag(EXCL_PLUGIN_FLAG_NODEFAULTDISABLED)

if SERVER then
	util.AddNetworkString("ESOpenVoteKick")
	local votes = {}
	local voteKickPlayer = NULL
	local voteKickPlayerID = "STEAM_0:0:0"
	local nextVoteKick = CurTime() + 60
	concommand.Add("excl_vote_yes",function(p)
		votes[p:UniqueID()] = true
	end)

	PLUGIN:AddCommand("votekick",function(p,a)
		if p:ESGetVIPTier() < 4 then p:ChatPrint("You need at least <hl>Carebear VIP</hl> to start a vote kick.") return end

		if not p or not p:IsValid() or not a or not a[1] then
			p:ESChatPrint("Invalid arguments passed to command <hl>votekick</hl>.")
			return
		end

		if nextVoteKick > CurTime() then p:ESChatPrint("The votekick system is currently on cooldown, wait <hl>"..math.Round(nextVoteKick-CurTime()).."</hl> more seconds.") return end

		if voteKickPlayer and IsValid(voteKickPlayer) then p:ESChatPrint("There already is a vote kick in progress.") return end

		if not a[2] then p:ESChatPrint("You must specify a reason.") return end

		local vic = ES.GetPlayerByName(a[1])

		if not vic then p:ESChatPrint("Player not found.") return end

		vic = vic[1]

		if not vic or not IsValid(vic) then p:ESChatPrint("Player not found.") return end

		local r
		if a[2] and a[2] ~= "" then
			r = table.concat(a," ",2)
		else
			r = ""
		end

		if vic:ESIsImmuneTo(p) then
			ES.SendMessagePlayerTried(p,vic:Nick(),"vote kick")
		end

		p:ESChatPrint("<hl>"..p:Nick().."</hl> has started a vote to kick <hl>"..vic:Nick().."</hl>.")

		voteKickPlayer = vic
		voteKickPlayerID = vic:SteamID()

		nextVoteKick = CurTime() + 300

		net.Start("ESOpenVoteKick")
		net.WriteEntity(vic)
		net.WriteString(r)
		net.Broadcast()

		votes = {}

		timer.Simple(60,function()
			local count = (table.Count(votes) or 0)
			if count > #player.GetAll()/2 then
				p:ESChatPrint("The vote kick succeeded <hl>"..p:Nick().."</hl> has been kicked and banned for 30 minutes.")
				if IsValid(voteKickPlayer) then
					ES.DropUser(voteKickPlayer:UserID(),"Voted off the server.")
				end
				ES.AddBan(voteKickPlayerID,"EXCLSERVER",30,false,"Voted off the server",IsValid(voteKickPlayer) and voteKickPlayer:Nick() or voteKickPlayerID,"EXCLSERVER")
			else
				p:ESChatPrint("The vote kick failed, <hl>"..(IsValid(vic) and vic:Nick() or voteKickPlayerID).."</hl> will not be kicked.")
			end
		end)
	end,0)
elseif CLIENT then
	local pnl
	net.Receive("ESOpenVoteKick",function()
		local user = net.ReadEntity()
		local reason = net.ReadString()

		if not user or not IsValid(user) or not reason then return end

		if pnl and IsValid(pnl) then pnl:Remove() end

		local a,b,c = ES.GetColorScheme()

		pnl = vgui.Create("esFrame")
		pnl:SetSize(280,110)
		pnl:SetTitle("Vote kick (60 seconds left)")
		pnl:SetPos(5,ScrH()-115)
		pnl:EnableCloseButton(false)
		pnl.timeCreate = CurTime()
		pnl.Think = function(self)
			self:SetTitle("Vote kick ("..math.ceil(self.timeCreate+60 - CurTime()).." seconds left)")
		end

		local txt = Label("Kick "..user:Nick().."?",pnl)
		txt:SetFont("ESDefaultBold")
		txt:SetColor(COLOR_WHITE)
		txt:SetPos(8,35)
		txt:SizeToContents()

		local txtRea = Label("Reason given: '"..reason.."'",pnl)
		txtRea:SetPos(8,txt.y + 5 + txt:GetTall())
		txtRea:SetColor(COLOR_WHITE)
		txtRea:SizeToContents()

		local yes = pnl:Add("esButton")
		yes:SetSize((pnl:GetWide()-5-5-5)/2,30)
		yes:SetPos(5,pnl:GetTall()-5-30)
		yes:SetText("Yes (F7)")
		yes.DoClick = function()
			RunConsoleCommand("excl_vote_yes")
			if pnl and IsValid(pnl) then pnl:Remove() end
		end

		local no = pnl:Add("esButton")
		no:SetSize(yes:GetWide(),30)
		no:SetPos(yes.x + yes:GetWide() + 5,yes.y)
		no:SetText("No (F8)")
		no.DoClick = function()
			if pnl and IsValid(pnl) then pnl:Remove() end
		end

		timer.Simple(60,function() if pnl and IsValid(pnl) then pnl:Remove() end end)
	end)

	local was_7pressed = false
	local was_8pressed = false
	hook.Add("Think","exclHandleF7F8Votes",function()
		if input.IsKeyDown(KEY_F7) and not was_7pressed then
			was_7pressed = true
			RunConsoleCommand("excl_vote_yes")
			if pnl and IsValid(pnl) then pnl:Remove() end
		elseif not input.IsKeyDown(KEY_F7) then
			was_7pressed = false
		end

		if input.IsKeyDown(KEY_F8) and not was_8pressed then
			was_8pressed = true
			if pnl and IsValid(pnl) then pnl:Remove() end
		elseif not input.IsKeyDown(KEY_F8) then
			was_8pressed = false
		end
	end)
end

PLUGIN()
