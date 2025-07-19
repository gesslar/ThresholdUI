local mainHeight = ThresholdUI.metrics.height
local inactiveHeight = ThresholdUI.metrics.inactiveHeight
local totalHeight = ThresholdUI.metrics.totalHeight
local fontName = ThresholdUI.Styles.InactiveFont
local fontSize = ThresholdUI.metrics.inactiveFontSize

ThresholdUI.InactiveContainer = ThresholdUI.InactiveContainer or Geyser.Container:new({
  name = "InactiveContainer",
  x = 0, y = -(totalHeight)+2,
  width = "100%", height = inactiveHeight,
})

ThresholdUI.InactiveLabel = ThresholdUI.InactiveLabel or Geyser.Label:new({
  name = "InactiveLabel",
  x = 0, y = 0,
  width = "100%", height = "100%",
  stylesheet = ThresholdUI.Styles.InactiveLabel,
  font = fontName, fontSize = fontSize,
  message = "You have been inactive for 0s"
}, ThresholdUI.InactiveContainer)

ThresholdUI.InactiveLabel:echo(nil, "nocolor", nil)
ThresholdUI.InactiveContainer:hide()

ThresholdUI.InactiveStart = nil
ThresholdUI.InactiveType = ""
ThresholdUI.InactivePhase = 0  -- Start at black
ThresholdUI.BreathSpeed = 0.02
ThresholdUI.BrightColor = {r = 18, g = 22, b = 25}

function ThresholdUI:UpdateInactiveGradient()
  local style = ThresholdUI.Styles.InactiveLabel

  local t = math.sin(self.InactivePhase) * 0.5 + 0.5  -- Oscillate between 0 and 1

  -- Interpolate between black and bright color
  local r = math.floor(self.BrightColor.r * t)
  local g = math.floor(self.BrightColor.g * t)
  local b = math.floor(self.BrightColor.b * t)

  local backgroundColor = string.format([[
    background-color: rgb(%d,%d,%d);
  ]], r, g, b)

  self.InactiveLabel:setStyleSheet(style .. backgroundColor)

  -- Update the breathing effect
  self.InactivePhase = self.InactivePhase + self.BreathSpeed
  if self.InactivePhase >= 2 * math.pi then
    self.InactivePhase = self.InactivePhase - 2 * math.pi
  end
end

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
  local output = f("You have been {self.InactiveType} for {InactiveMess}")

  self.InactiveLabel:echo(output)
end

function ThresholdUI:StartInactiveTimer()
  if self.InactiveStart ~= nil then
    return
  end

  self.InactiveStart = os.time()
  if gmcp.Char.Status.inactive_type == "trance" then
    self.InactiveType = "Trancing"
  elseif gmcp.Char.Status.inactive_type == "meditate" then
    self.InactiveType = "Meditating"
  else
    self.InactiveType = "Resting"
  end

  self.InactivePhase = 0  -- Start at black
  self:UpdateInactiveGradient() -- Reset the gradient
  self.InactiveContainer:show()

  setBorderBottom(totalHeight)
  registerNamedTimer(self.AppName, self.Timers.InactiveTimer, 0.1, function() self:UpdateInactiveDisplay() end, true)
  registerNamedTimer(self.AppName, self.Timers.InactiveEffectTimer, 0.05, function() self:UpdateInactiveGradient() end, true)
end

function ThresholdUI:CancelInactiveTimer()
  if self.InactiveStart == nil then
    return
  end

  self.InactiveStart = nil
  self.InactiveContainer:hide()

  setBorderBottom(mainHeight)
  deleteNamedTimer(self.AppName, self.Timers.InactiveTimer)
  deleteNamedTimer(self.AppName, self.Timers.InactiveEffectTimer)
end

function ThresholdUI:DoInactiveTimer()
  if gmcp.Char.Status.inactive ~= "0" and self.InactiveStart == nil then
    self:StartInactiveTimer()
    raiseEvent("ThresholdUI.FeedbackToggle")
  elseif gmcp.Char.Status.inactive == "0" and self.InactiveStart ~= nil then
    self:CancelInactiveTimer()
    raiseEvent("ThresholdUI.FeedbackToggle")
  end
end
