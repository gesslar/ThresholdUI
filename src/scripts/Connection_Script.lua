ThresholdUI.ConnectionTimer = nil
ThresholdUI:LoadPrefs()
ThresholdUI.ConnectionHandlers = {
    {"sysConnectionEvent", f[[ThresholdUI:ConnectionScript()]]},
    {"sysDisconnectionEvent", f[[ThresholdUI:DisconnectionScript()]]},
}

function ThresholdUI:ConnectionScript()
    self:RegisterEventHandlers()
    raiseEvent("ThresholdUI.EnablePing")
    registerNamedTimer(self.AppName, self.AppName .. ".Connection", 1, function()
        deleteNamedTimer(self.AppName, self.AppName .. ".Connection")
        self:modifyModules()
        if ThresholdUI.Prefs.HealTick == false then
            raiseEvent("ThresholdUI.ToggleHealTick", "off", true)
        end
        deleteNamedTimer(self.AppName, self.AppName .. ".Connection")
    end)
end

function ThresholdUI:DisconnectionScript()
    raiseEvent("ThresholdUI.DisablePing")
    raiseEvent("ThresholdUI.ResetPingHistory")
    ThresholdUI:DeregisterEventHandlers()
end

function ThresholdUI.modifyModules()
    -- Enable Modules
    for _, module in pairs(ThresholdUI.enableModules) do
      gmod.enableModule(ThresholdUI.AppName, module)
    end

    -- Disable Modules
    local DisableString =
      f[[Core.Supports.Remove [ {table.concat(ThresholdUI.disableModules, ", ")} ] ]]
      sendGMCP(DisableString)
end

for _, v in ipairs(ThresholdUI.ConnectionHandlers) do
    local event, handler = v[1], v[2]
    registerNamedEventHandler(ThresholdUI.AppName, ThresholdUI.AppName .. "." .. event, event, handler)
end
