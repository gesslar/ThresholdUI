ThresholdUI.ConnectionTimer = nil
ThresholdUI:LoadPrefs()

function ThresholdUI:ConnectionScript()
    self:RegisterEventHandlers()
    raiseEvent("ThresholdUI.EnablePing")
    registerNamedTimer(self.AppName, self.AppName .. ".Connection", 1, function()
        deleteNamedTimer(self.AppName, self.AppName .. ".Connection")
        self:modifyModules()
        if ThresholdUI.Prefs.HealTick == false then
            raiseEvent("ThresholdUI.ToggleHealTick", "off", true)
        end
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
    ThresholdUI.ConnectionTimer = nil
end

registerNamedEventHandler(ThresholdUI.AppName, ThresholdUI.AppName .. ".ConnectionScript", "sysConnectionEvent", function() ThresholdUI:ConnectionScript() end)
registerNamedEventHandler(ThresholdUI.AppName, ThresholdUI.AppName .. ".DisconnectionScript", "sysDisconnectionEvent", function() ThresholdUI:DisconnectionScript() end)
