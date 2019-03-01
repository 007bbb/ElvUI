local E, L, V, P, G = unpack(select(2, ...)); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local B = E:GetModule('Blizzard');

local _G = _G
local hooksecurefunc = hooksecurefunc

local Holder = CreateFrame("Frame", "LevelUpBossBannerHolder", E.UIParent)
Holder:SetSize(200, 20)
Holder:SetPoint("TOP", E.UIParent, "TOP", 0, -120)

local function Reanchor(frame, _, anchor)
	if anchor and (anchor ~= Holder) then
		frame:ClearAllPoints()
		frame:SetPoint("TOP", Holder)
	end
end

function B:Handle_LevelUpDisplay_BossBanner()
	E:CreateMover(Holder, "LevelUpBossBannerMover", L["Level Up Display / Boss Banner"])

	_G.LevelUpDisplay:ClearAllPoints()
	_G.LevelUpDisplay:SetPoint("TOP", Holder)
	hooksecurefunc(_G.LevelUpDisplay, "SetPoint", Reanchor)

	_G.BossBanner:ClearAllPoints()
	_G.BossBanner:SetPoint("TOP", Holder)
	hooksecurefunc(_G.BossBanner, "SetPoint", Reanchor)
end
