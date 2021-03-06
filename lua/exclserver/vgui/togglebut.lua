
local BUTTON = {}
function BUTTON:Init()
	self.DoClick = function() end
	self.Text = ""
	self.Toggled = true
	self.moveX = 0
	self.hoverAlpha = 0
	self.HideButton = false
	self:SetTall(20)
	self:SetWide((20)*2+2);
end
function BUTTON:OnMouseReleased()
	if self.HideButton then return end

	self.Toggled = not self.Toggled
	self:DoClick(self.Toggled)
end
function BUTTON:GetChecked()
	return self.Toggled
end
function BUTTON:SetChecked(b)
	self.Toggled = b
end
function BUTTON:SetText( str )
	if self.HideButton then return end

	self.Text = str
end
function BUTTON:Paint(w,h)
	draw.SimpleText(self.Text, "ESDefault", (h*2) + 8, (h/2), ES.Color.White, 0, TEXT_ALIGN_CENTER)

	if self.HideButton then return end

	-- draw the button thingy
	if self.Toggled then
		self.moveX = Lerp(FrameTime()*18,self.moveX,0)
	else
		self.moveX = Lerp(FrameTime()*18,self.moveX,h+2)
	end


	local x,y=1,1



	draw.RoundedBox(h/2,x-1,y-1,(h)*2+2,h + 2, Color(0,0,0,200))

	draw.SimpleText("I","ESDefault-",x+(h)/2 + (h-2), y+(h-2)/2,ES.Color.White,1,1)
	draw.SimpleText("O","ESDefault-",x+(h)/2, y+(h-2)/2,ES.Color.White,1,1)

	draw.RoundedBox((h-4)/2,x+self.moveX+1,y+1,h-4,h-4, Color(213,213,213))


end
vgui.Register( "esToggleButton", BUTTON, "Panel" )
