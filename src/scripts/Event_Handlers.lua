ThresholdUI.EventHandlers = ThresholdUI.EventHandlers or {
  {"gmcp.Char.Vitals", nil, "ThresholdUI:UpdateVitals"},
  {"gmcp.Char.Afflictions.Add", nil, "ThresholdUI:Afflictions_Add"},
  {"gmcp.Char.Afflictions.Remove", nil, "ThresholdUI:Afflictions_Remove"},
  {"gmcp.Char.Afflictions.List", nil, "ThresholdUI:Afflictions_List"},
  {"gmcp.Char.Shielding", nil, "ThresholdUI:UpdateShielding"},
  {"gmcp.Char.Status", "XP", "ThresholdUI:UpdateXP"},
  {"gmcp.Char.Status", "Foe", "ThresholdUI:UpdateFoe"},
  {"gmcp.Char.Status", "Capacity", "ThresholdUI:UpdateCapacity"},
  {"gmcp.Char.Status", "Tummy", "ThresholdUI:UpdateTummy"},
  {"gmcp.Char.Status", "HealBank", "ThresholdUI:UpdateHealBank"},
  {"gmcp.Char.Status", "HealTick", "ThresholdUI:UpdateHealTick"},
  {"gmcp.Char.Status", "Inactive", "ThresholdUI:DoInactiveTimer"},
  {"gmcp.Char.Feedback", "Feedback", "ThresholdUI:UpdateFeedback"},
  {"ThresholdUI.FeedbackToggle", nil, "ThresholdUI:FeedbackToggle"},
}

-- The named-handler label for an EventHandlers entry, shared by register and
-- deregister so the two can't drift apart.
function ThresholdUI:EventHandlerLabel(event, subevent)
  local label = event

  if not string.match(event, "^" .. self.AppName .. "%.") then
    label = self.AppName .. "." .. event
  end

  if subevent then
    label = label .. "." .. subevent
  end

  return label
end

function ThresholdUI:RegisterEventHandlers()
  for _, v in ipairs(self.EventHandlers) do
    local event, subevent, handler = v[1], v[2], v[3]

    registerNamedEventHandler(self.AppName, self:EventHandlerLabel(event, subevent), event, handler)
  end
end

function ThresholdUI:DeregisterEventHandlers()
  for _, v in ipairs(self.EventHandlers) do
    local event, subevent = v[1], v[2]

    deleteNamedEventHandler(self.AppName, self:EventHandlerLabel(event, subevent))
  end
end

-- /tui only touches the UI, so it stays registered for the life of the
-- package instead of following the connection.
ThresholdUI.CommandHandlers = {
  {"ThresholdUI.Command", "ThresholdUI:Command"},
}

for _, v in ipairs(ThresholdUI.CommandHandlers) do
  local event, handler = v[1], v[2]

  registerNamedEventHandler(ThresholdUI.AppName, ThresholdUI:EventHandlerLabel(event), event, handler)
end
