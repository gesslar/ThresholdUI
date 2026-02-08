ThresholdUI.ConnectionTimer = nil
ThresholdUI:LoadPrefs()

function ThresholdUI:ConnectionScript()
  self:RegisterEventHandlers()

  registerNamedTimer(self.AppName, self.Timers.Connection, 1, function()
    deleteNamedTimer(self.AppName, self.Timers.Connection)
    self:modifyModules()

    if ThresholdUI.Prefs.HealTick == false then
      raiseEvent("ThresholdUI.ToggleHealTick", "off", true)
    end

    if ThresholdUI.Prefs.TimeBox == false then
      raiseEvent("ThresholdUI.ToggleTimeBox", "off", true)
    end

    deleteNamedTimer(self.AppName, self.Timers.Connection)
  end)
end

function ThresholdUI:DisconnectionScript()
  ThresholdUI:DeregisterEventHandlers()
end

ThresholdUI.ConnectionHandlers = {
  { "sysConnectionEvent",    function() ThresholdUI:ConnectionScript() end },
  { "sysDisconnectionEvent", function() ThresholdUI:DisconnectionScript() end },
}

function ThresholdUI.modifyModules()
  -- Enable Modules
  for _, module in pairs(ThresholdUI.enableModules) do
    gmod.enableModule(ThresholdUI.AppName, module)
  end

  -- Disable Modules
  local DisableString =
      f [[Core.Supports.Remove [ {table.concat(ThresholdUI.disableModules, ", ")} ] ]]

  sendGMCP(DisableString)
end

for _, v in ipairs(ThresholdUI.ConnectionHandlers) do
  local event, handler = v[1], v[2]
  registerNamedEventHandler(ThresholdUI.AppName, ThresholdUI.AppName .. "." .. event, event, handler)
end
