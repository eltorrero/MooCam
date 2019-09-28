SLASH_MOOCAM1 = "/moocam"
function SlashCmdList.MOOCAM(msg, editbox)
    print("\124cffff9933MooCam "..GetAddOnMetadata("MooCam", "Version").."\124r")
    print("\124cffff9933Camera setting 1 will be applied on dismounting event.\124r")
    print("\124cffff9933Camera setting 2 will be applied on mounting event.\124r")
end

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")

f:SetScript("OnEvent", function(self, event, name)
    if event=="ADDON_LOADED" and name=="MooCam" then
        f:UnregisterEvent("ADDON_LOADED")
        self.timeSinceLastUpdate = 0
        self.mountState = IsMounted()
    end
end)

f:SetScript("OnUpdate", function(self, elapsedTime)
    self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsedTime
    if self.timeSinceLastUpdate > 1.0 then
        if self.mountState ~= IsMounted() then
            SetView(IsMounted() and 2 or 1)
            self.mountState = IsMounted()
        end
        self.timeSinceLastUpdate = 0
    end
end)
