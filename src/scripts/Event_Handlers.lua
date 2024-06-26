ThresholdUI.EventHandlers = ThresholdUI.EventHandlers or {
    {"gmcp.Char.Vitals", nil, f[[ThresholdUI:UpdateVitals]]},
    {"gmcp.Char.Afflictions.Add", nil, f[[ThresholdUI:Afflictions_Add]]},
    {"gmcp.Char.Afflictions.Remove", nil, f[[ThresholdUI:Afflictions_Remove]]},
    {"gmcp.Char.Shielding", nil, f[[ThresholdUI:UpdateShielding]]},
    {"gmcp.Char.Status", "XP", f[[ThresholdUI:UpdateXP]]},
    {"gmcp.Char.Status", "Foe", f[[ThresholdUI:UpdateFoe]]},
    {"gmcp.Char.Status", "Capacity", f[[ThresholdUI:UpdateCapacity]]},
    {"gmcp.Char.Status", "Tummy", f[[ThresholdUI:UpdateTummy]]},
    {"gmcp.Char.Status", "HealBank", f[[ThresholdUI:UpdateHealBank]]},
    {"gmcp.Char.Status", "HealTick", f[[ThresholdUI:UpdateHealTick]]},
    {"gmcp.Char.Status", "Inactive", f[[ThresholdUI:DoInactiveTimer]]},
    {"ThresholdUI.ToggleHealTick", nil, f[[ThresholdUI:ToggleHealTick]]},
    {"gmcp.Char.Feedback", nil, f[[ThresholdUI:UpdateFeedback]]},
    {"ThresholdUI.FeedbackToggle", nil, f[[ThresholdUI:FeedbackToggle]]},
    {"gmcp.Char.Feedback", nil, f[[ThresholdUI:UpdateFeedback]]},
    {"ThresholdUI.FeedbackToggle", nil, f[[ThresholdUI:FeedbackToggle]]},
    -- {"gmcp.Core.Ping", nil, function() ThresholdUI:ReceivePing() end},
    -- {"ThresholdUI.Ping", nil, function() ThresholdUI:DisplayPing() end},
    -- {"ThresholdUI.EnablePing", nil, function() ThresholdUI:EnablePing() end},
    -- {"ThresholdUI.DisablePing", nil, function() ThresholdUI:DisablePing() end},
    -- {"ThresholdUI.ResetPingHistory", nil, function() ThresholdUI:ResetPingHistory() end},
    -- {"gmcp.Char.Status", "Breath", function() ThresholdUI:UpdateBreath() end},
}

function ThresholdUI:RegisterEventHandlers()
    for _, v in ipairs(self.EventHandlers) do
        local event, subevent, handler = v[1], v[2], v[3]

        local label = event
        if not string.match(event, "^" .. self.AppName .. "%.") then
            label = self.AppName .. "." .. event
        end

        if subevent then
            label = label .. "." .. subevent
        end

        registerNamedEventHandler(self.AppName, label, event, handler)
    end
end

function ThresholdUI:DeregisterEventHandlers()
    for i, v in ipairs(self.EventHandlers) do
        local event, subevent = v[1], v[2]
        local label = event

        if not string.match(event, "^" .. self.AppName .. "%.") then
            label = self.AppName .. "." .. event
        end

        if subevent then
            label = label .. "." .. subevent
        end

        deleteNamedEventHandler(self.AppName, label)
    end
end
