local E, L, V, P, G = unpack(select(2, ...)); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local S = E:GetModule('Skins')

--Cache global variables
--Lua functions
local _G = _G
--WoW API / Variables

local function LoadSkin()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.talkinghead ~= true then return end

	local TalkingHeadFrame = _G.TalkingHeadFrame

	--TalkingHeadFrame:StripTextures()
	
	--TalkingHeadFrame.MainFrame:StripTextures()
	TalkingHeadFrame.PortraitFrame:StripTextures()
	
	
	TalkingHeadFrame.BackgroundFrame.TextBackground:SetAtlas(nil)
	TalkingHeadFrame.PortraitFrame.Portrait:SetAtlas(nil)
	TalkingHeadFrame.MainFrame.Model.PortraitBg:SetAtlas(nil)
	TalkingHeadFrame.MainFrame.Model:CreateBackdrop("Transparent")
	TalkingHeadFrame.MainFrame.Model.backdrop:ClearAllPoints()
	TalkingHeadFrame.MainFrame.Model.backdrop:SetPoint("CENTER")
	TalkingHeadFrame.MainFrame.Model.backdrop:SetSize(120, 119)

	TalkingHeadFrame.BackgroundFrame.TextBackground.SetAtlas = E.noop
	TalkingHeadFrame.PortraitFrame.Portrait.SetAtlas = E.noop
	TalkingHeadFrame.MainFrame.Model.PortraitBg.SetAtlas = E.noop

	TalkingHeadFrame.NameFrame.Name:SetTextColor(1, 0.82, 0.02)
	TalkingHeadFrame.NameFrame.Name.SetTextColor = E.noop
	TalkingHeadFrame.NameFrame.Name:SetShadowColor(0, 0, 0, 1)
	TalkingHeadFrame.NameFrame.Name:SetShadowOffset(2, -2)

	TalkingHeadFrame.TextFrame.Text:SetTextColor(1, 1, 1)
	TalkingHeadFrame.TextFrame.Text.SetTextColor = E.noop
	TalkingHeadFrame.TextFrame.Text:SetShadowColor(0, 0, 0, 1)
	TalkingHeadFrame.TextFrame.Text:SetShadowOffset(2, -2)

	TalkingHeadFrame.MainFrame.CloseButton:Kill()
end

S:AddCallbackForAddon("Blizzard_TalkingHeadUI", "TalkingHead", LoadSkin)
