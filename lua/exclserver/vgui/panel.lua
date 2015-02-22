--pannel
vgui.Register( "esPanel", {
	Paint = function(self,w,h)
		draw.RoundedBox(2,0,0,w,h,self.color) 

		surface.SetDrawColor(ES.Color["#00000022"])
		surface.DrawRect(0,0,w,1)
		surface.DrawRect(0,h-1,w,1)
		surface.DrawRect(0,1,1,h-2)
		surface.DrawRect(w-1,1,1,h-2)

		
	end,
	PerformLayout = function(self)
		if self._inlineElements then
			local w,h=self:GetWide(),self:GetTall();

			local x=0;
			for k,v in ipairs(self._inlineElements)do
				v.x=x;
				x=x+v:GetWide();
			end
		end
	end,
	SetColor = function(self,color)
		self.color = color
	end,
	Init = function(self)
		self.color = ES.GetColorScheme(2)
	end,
	Inline=function(self,panel)
		if not IsValid(panel) then return end

		if not self._inlineElements then
			self._inlineElements={};
		end

		table.insert(self._inlineElements,panel);

	end,
}, "Panel" )