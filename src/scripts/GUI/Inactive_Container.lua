ThresholdUI.InactiveContainer = ThresholdUI.InactiveContainer or
    Geyser.Container:new({
        name = "InactiveContainer",
        x = 0,
        y = -(ThresholdUI.metrics.height + ThresholdUI.metrics.inactiveHeight),
        height = ThresholdUI.metrics.inactiveHeight,
        width = "100%",
    })

ThresholdUI.InactiveLabel = ThresholdUI.InactiveLabel or
    Geyser.Label:new({
        name = "InactiveLabel",
        x = 0, y = 0, height = "100%", width = "100%"
    },
    ThresholdUI.InactiveContainer)

ThresholdUI.InactiveLabel:setFontSize(11)
ThresholdUI.InactiveContainer:hide()
ThresholdUI.InactiveTimerId = nil
ThresholdUI.InactiveStart = 0
ThresholdUI.InactiveType = ""

function ThresholdUI:FormatDuration(duration)
    if duration < 1 then return "0s" end
    local days = math.floor(duration / 86400)
    local remaining = duration % 86400
    local hours = math.floor(remaining / 3600)
    remaining = remaining % 3600
    local minutes = math.floor(remaining / 60)
    remaining = remaining % 60
    local seconds = remaining
    local answer

    if days > 0 then
        answer = f"{answer or \"\"}{days}d "
    end
    if hours > 0 then
        answer = f"{answer or \"\"}{hours}h "
    end
    if minutes > 0 then
        answer = f"{answer or \"\"}{minutes}m "
    end
    if seconds > 0 then
        answer = f"{answer or \"\"}{seconds}s"
    end
    return answer
end

function ThresholdUI:UpdateInactiveDisplay()
    local InactiveMess = self:FormatDuration(os.time() - self.InactiveStart)
    local output = f("<center>You have been {self.InactiveType} for {InactiveMess}</center>")
    self.InactiveLabel:echo(output)
end

function ThresholdUI:StartInactiveTimer()
    self.InactiveContainer:show()
    setBorderBottom(self.metrics.height + self.metrics.inactiveHeight)
    self:UpdateInactiveDisplay()
    registerNamedTimer(self.AppName, self.AppName .. ".InactiveTimer", 0.1, function() self:UpdateInactiveDisplay() end, true)
end

function ThresholdUI:CancelInactiveTimer()
    self.InactiveContainer:hide()
    setBorderBottom(self.metrics.height)
    deleteNamedTimer(self.AppName, self.AppName .. ".InactiveTimer")
end

function ThresholdUI:DoInactiveTimer()
    if gmcp.Char.Status.inactive ~= "0" then
        if not resumeNamedTimer(self.AppName, self.AppName .. ".InactiveTimer") then
            self.InactiveStart = os.time()
            if gmcp.Char.Status.inactive_type == "trance" then
                self.InactiveType = "Trancing"
            elseif gmcp.Char.Status.inactive_type == "meditate" then
                self.InactiveType = "Meditating"
            else
                self.InactiveType = "Resting"
            end
            self:StartInactiveTimer()
        end
    else
        self:CancelInactiveTimer()
    end

    raiseEvent("ThresholdUI.FeedbackToggle")
end
