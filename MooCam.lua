SLASH_MOOCAM1 = "/moocam";
function SlashCmdList.MOOCAM(msg, editbox)
    print("\124cffff9933MooCam " .. GetAddOnMetadata("MooCam", "Version") .. "\124r")
    print("\124cffff9933Camera setting 1 will be applied on dismounting event.\124r")
    print("\124cffff9933Camera setting 2 will be applied on mounting event.\124r")
end

local f = CreateFrame("FRAME")

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LEVEL_UP")

f:SetScript("OnEvent", function(self, event, addon_name)
    if event == "PLAYER_LEVEL_UP" then DoEmote("MOO") end
    if event == "ADDON_LOADED" and addon_name == "MooCam" then
        f:UnregisterEvent("ADDON_LOADED")
        self.time_since_last_update = 0
        self.mount_state = IsMounted()
    end
end)

f:SetScript("OnUpdate", function(self, elapsed_time)
    self.time_since_last_update = self.time_since_last_update + elapsed_time
    if self.time_since_last_update > 1.0 then
        if self.mount_state ~= IsMounted() then
            SetView(IsMounted() and 2 or 1)
            self.mount_state = IsMounted()
        end
        self.time_since_last_update = 0
    end
end)
