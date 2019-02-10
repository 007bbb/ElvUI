local E, L, V, P, G = unpack(select(2, ...)); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

--Cache global variables
local _G = _G
--Lua functions
local abs, floor = math.abs, math.floor
--WoW API / Variables

function E:SetResolutionVariables(width, height)
	if E.global.general.eyefinity and width >= 3840 then
		-- because some user enable bezel compensation, we need to find the real width of a single monitor.
		-- I don't know how it really work, but i'm assuming they add pixel to width to compensate the bezel. :P

		-- HQ resolution
		if width >= 9840 then width = 3280; end							-- WQSXGA
		if width >= 7680 and width < 9840 then width = 2560; end		-- WQXGA
		if width >= 5760 and width < 7680 then width = 1920; end		-- WUXGA & HDTV
		if width >= 5040 and width < 5760 then width = 1680; end		-- WSXGA+

		-- adding height condition here to be sure it work with bezel compensation because WSXGA+ and UXGA/HD+ got approx same width
		if width >= 4800 and width < 5760 and height == 900 then width = 1600; end	-- UXGA & HD+

		-- low resolution screen
		if width >= 4320 and width < 4800 then width = 1440; end		-- WSXGA
		if width >= 4080 and width < 4320 then width = 1360; end		-- WXGA
		if width >= 3840 and width < 4080 then width = 1224; end		-- SXGA & SXGA (UVGA) & WXGA & HDTV

		-- register a constant, we will need it later for launch.lua
		E.eyefinity = width
	end
end

--Determine if Eyefinity is being used, setup the pixel perfect script.
function E:UIScale()
	local UIParent = _G.UIParent

	local scale = E.global.general.UIScale
	UIParent:SetScale(scale)

	local effectiveScale = UIParent:GetEffectiveScale()
	local width, height = E.screenwidth, E.screenheight

	E.mult = effectiveScale / scale
	E.Spacing = (E.PixelMode and 0) or E.mult
	E.Border = (E.PixelMode and E.mult) or E.mult*2

	--Check if we are using `E.eyefinity`
	E:SetResolutionVariables(width, height)

	--Resize E.UIParent if Eyefinity is on.
	local testingEyefinity = false
	if testingEyefinity then
		-- Eyefinity Test: Resize the E.UIParent to be smaller than it should be, all objects inside should relocate.
		-- Dragging moveable frames outside the box and reloading the UI ensures that they are saving position correctly.
		width, height = UIParent:GetWidth() - 250, UIParent:GetHeight() - 250
	elseif E.eyefinity and height > 1200 then
		-- find a new width value of E.UIParent for screen #1.
		local uiHeight = UIParent:GetHeight()
		width, height = E.eyefinity / (height / uiHeight), uiHeight
	else
		width, height = UIParent:GetSize()
	end

	E.UIParent:SetSize(width, height)
	E.UIParent.origHeight = E.UIParent:GetHeight()
	E.UIParent:ClearAllPoints()

	if E.global.general.commandBarSetting == "ENABLED_RESIZEPARENT" then
		E.UIParent:Point("BOTTOM")
	else
		E.UIParent:Point("CENTER")
	end

	--Calculate potential coordinate differences
	E.diffGetLeft = E:Round(abs(UIParent:GetLeft() - E.UIParent:GetLeft()))
	E.diffGetRight = E:Round(abs(UIParent:GetRight() - E.UIParent:GetRight()))
	E.diffGetTop = E:Round(abs(UIParent:GetTop() - E.UIParent:GetTop()))
	E.diffGetBottom = E:Round(abs(UIParent:GetBottom() - E.UIParent:GetBottom()))
end

-- pixel perfect script of custom ui scale.
function E:Scale(x)
	return E.mult * floor(x/E.mult+.5)
end
