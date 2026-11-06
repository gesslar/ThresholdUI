ThresholdUI:LoadPrefs()

function ThresholdUI:ConnectionScript()
  self:RegisterEventHandlers()

  registerNamedTimer(self.AppName, self.Timers.Connection, 1, function()
    deleteNamedTimer(self.AppName, self.Timers.Connection)
    self:modifyModules()
    -- Stun and immobile are on the character and outlast a reconnect, so ask
    -- for the current set rather than trust what we had before
    sendGMCP("Char.Afflictions.List")
  end)
end

function ThresholdUI:DisconnectionScript()
  ThresholdUI:DeregisterEventHandlers()

  -- Disconnecting ends a rest in-game, so end the resting bar with it
  ThresholdUI:CancelInactiveTimer()

  -- Mudlet keeps gmcp across connections, so a psion's feedback would
  -- otherwise keep the bar up for the next character logged in
  if gmcp.Char then
    gmcp.Char.Feedback = nil
  end

  ThresholdUI:FeedbackToggle()
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
      "Core.Supports.Remove [ " .. table.concat(ThresholdUI.disableModules, ", ") .. " ]"

  sendGMCP(DisableString)
end

for _, v in ipairs(ThresholdUI.ConnectionHandlers) do
  local event, handler = v[1], v[2]
  registerNamedEventHandler(ThresholdUI.AppName, ThresholdUI.AppName .. "." .. event, event, handler)
end
