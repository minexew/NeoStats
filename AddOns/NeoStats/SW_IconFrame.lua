--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005, 2006 Dan Gilbert
	Email me at loglow@gmail.com

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

function SW_IconFrame_OnClick()
	SW_IconMenuInit();
    SW_ToggleIconMenu();
end

function NeoStatsIcon_Init()
	if(AtlasOptions.AtlasButtonShown) then
		AtlasButtonFrame:Show();
	else
		AtlasButtonFrame:Hide();
	end
end

function NeoStatsIcon_Toggle()
	if(AtlasButtonFrame:IsVisible()) then
		AtlasButtonFrame:Hide();
		AtlasOptions.AtlasButtonShown = false;
	else
		AtlasButtonFrame:Show();
		AtlasOptions.AtlasButtonShown = true;
	end
	AtlasOptions_Init();
end

function SW_IconFrame_UpdatePosition()
    -- TODO: fix this
    local radius = SW_Settings["IconRadius"] or 78
    local position = SW_Settings["IconPosition"] or 85

	SW_IconFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (radius * cos(position)),
		(radius * sin(position)) - 55
	);
	AtlasOptions_Init();
end

-- Thanks to Yatlas for this code
function SW_IconFrame_BeingDragged()
    -- Thanks to Gello for this code
    local xpos,ypos = GetCursorPosition() 
    local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom() 

    xpos = xmin-xpos/UIParent:GetScale()+70 
    ypos = ypos/UIParent:GetScale()-ymin-70 

    SW_IconFrame_SetPosition(math.deg(math.atan2(ypos,xpos)));
end

function SW_IconFrame_SetPosition(v)
    if(v < 0) then
        v = v + 360;
    end

    SW_Settings["IconPosition"] = v;
    SW_IconFrame_UpdatePosition();
end

function SW_IconFrame_OnEnter()
    GameTooltip:SetOwner(this, "ANCHOR_LEFT");
    GameTooltip:SetText(SW_ICON_TOOLTIP_TITLE);
	GameTooltipTextLeft1:SetTextColor(1, 1, 1);
    GameTooltip:AddLine(SW_ICON_TOOLTIP_HINT);
    GameTooltip:Show();
end