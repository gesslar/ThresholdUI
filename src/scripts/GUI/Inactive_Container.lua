ThresholdUI.InactiveContainer = ThresholdUI.InactiveContainer or Geyser.Container:new({
  name = "InactiveContainer",
  x = 0, y = -(ThresholdUI.metrics.height + ThresholdUI.metrics.inactiveHeight)+2,
  width = "100%", height = ThresholdUI.metrics.inactiveHeight,
})

ThresholdUI.InactiveLabel = ThresholdUI.InactiveLabel or Geyser.Label:new({
  name = "InactiveLabel",
  x = 0, y = 0,
  width = "100%", height = "100%",
  stylesheet = ThresholdUI.Styles.InactiveLabel,
  fontSize = ThresholdUI.metrics.inactiveFontSize,
  message = "You have been inactive for 0s"
}, ThresholdUI.InactiveContainer)

ThresholdUI.InactiveLabel:echo(nil, "nocolor", nil)
ThresholdUI.InactiveContainer:hide()

ThresholdUI.InactiveStart = nil
ThresholdUI.InactiveType = ""
ThresholdUI.InactivePhase = 0  -- Start at black
ThresholdUI.BreathSpeed = 0.02
ThresholdUI.DarkColor = {0, 0, 0}
ThresholdUI.BrightColor = {18, 22, 25}  -- Previously the middle color, now the brightest

function ThresholdUI:UpdateInactiveGradient()
  local style = ThresholdUI.Styles.InactiveLabel

  local t = math.sin(self.InactivePhase) * 0.5 + 0.5  -- Oscillate between 0 and 1

  -- Interpolate between dark and bright color (the sine already eases it)
  local rgb = self.glu.colour.interpolate(self.DarkColor, self.BrightColor, t * 100, "linear")

  local backgroundColor = string.format([[
    background-color: rgb(%d,%d,%d);
  ]], rgb[1], rgb[2], rgb[3])

  self.InactiveLabel:setStyleSheet(style .. backgroundColor)

  -- Update the breathing effect
  self.InactivePhase = self.InactivePhase + self.BreathSpeed
  if self.InactivePhase >= 2 * math.pi then
    self.InactivePhase = self.InactivePhase - 2 * math.pi
  end
end

function ThresholdUI:UpdateInactiveDisplay()
  local InactiveMess = self.glu.date.shms(os.time() - self.InactiveStart, true)
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

  setBorderBottom(self.metrics.height + self.metrics.inactiveHeight)
  registerNamedTimer(self.AppName, self.Timers.InactiveTimer, 0.1, function() self:UpdateInactiveDisplay() end, true)
  registerNamedTimer(self.AppName, self.Timers.InactiveEffectTimer, 0.05, function() self:UpdateInactiveGradient() end, true)
end

function ThresholdUI:CancelInactiveTimer()
  if self.InactiveStart == nil then
    return
  end

  self.InactiveStart = nil
  self.InactiveContainer:hide()

  setBorderBottom(self.metrics.height)
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
