-- Char.Vitals information
ThresholdUI.VitalsBox = ThresholdUI.VitalsBox or Geyser.VBox:new({
  name = "VitalsBox",
  width = 280,
  h_policy = Geyser.Fixed
}, ThresholdUI.BarBox)

-- HP
ThresholdUI.HPContainer = ThresholdUI.HPContainer or Geyser.Container:new({
  name = "HPContainer",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
}, ThresholdUI.VitalsBox);

ThresholdUI.HPBar = ThresholdUI.HPBar or Geyser.Gauge:new({
  name = "HPBar",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
  show_text = false
}, ThresholdUI.HPContainer)

ThresholdUI.HPBar:setStyleSheet(
  ThresholdUI.Styles.HPFrontNormal,
  ThresholdUI.Styles.HPBack,
  ThresholdUI.Styles.GaugeText
)
ThresholdUI.HPBar.text:setFontSize(ThresholdUI.metrics.gaugeFontSize)
ThresholdUI.HPBar.text:echo(nil, "nocolor", nil)

ThresholdUI.HPLabel = ThresholdUI.HPLabel or Geyser.Label:new({
  name = "HPLabel",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
  message = "HP"
}, ThresholdUI.HPContainer)

ThresholdUI.HPLabel:setStyleSheet(ThresholdUI.Styles.GaugeLabel)
ThresholdUI.HPLabel:setFontSize(ThresholdUI.metrics.gaugeLabelFontSize)
ThresholdUI.HPLabel:echo(nil, "nocolor", nil)

-- SP
ThresholdUI.SPContainer = ThresholdUI.SPContainer or Geyser.Container:new({
  name = "SPContainer",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
}, ThresholdUI.VitalsBox);

ThresholdUI.SPBar = ThresholdUI.SPBar or Geyser.Gauge:new({
  name = "SPBar",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%"
}, ThresholdUI.SPContainer)

ThresholdUI.SPBar:setStyleSheet(
  ThresholdUI.Styles.SPFrontNormal,
  ThresholdUI.Styles.SPBack,
  ThresholdUI.Styles.GaugeText
)

ThresholdUI.SPBar.text:setFontSize(ThresholdUI.metrics.gaugeFontSize)
ThresholdUI.SPBar.text:echo(nil, "nocolor", nil)

ThresholdUI.SPLabel = ThresholdUI.SPLabel or Geyser.Label:new({
  name = "SPLabel",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
  message = "SP"
}, ThresholdUI.SPContainer)

ThresholdUI.SPLabel:setStyleSheet(ThresholdUI.Styles.GaugeLabel)
ThresholdUI.SPLabel:setFontSize(ThresholdUI.metrics.gaugeLabelFontSize)
ThresholdUI.SPLabel:echo(nil, "nocolor", nil)

-- EP
ThresholdUI.EPContainer = ThresholdUI.EPContainer or Geyser.Container:new({
  name = "EPContainer",
  x = 30,
  y = 0,
  width = "100%",
  height = "100%",
}, ThresholdUI.VitalsBox);

ThresholdUI.EPBar = ThresholdUI.EPBar or Geyser.Gauge:new({
  name = "EPBar",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%"
}, ThresholdUI.EPContainer)

ThresholdUI.EPBar:setStyleSheet(
  ThresholdUI.Styles.EPFrontNormal,
  ThresholdUI.Styles.EPBack,
  ThresholdUI.Styles.GaugeText
)
ThresholdUI.EPBar.text:setFontSize(ThresholdUI.metrics.gaugeFontSize)
ThresholdUI.EPBar.text:echo(nil, "nocolor", nil)

ThresholdUI.EPLabel = ThresholdUI.EPLabel or Geyser.Label:new({
  name = "EPLabel",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
  message = "EP"
}, ThresholdUI.EPContainer)

ThresholdUI.EPLabel:setStyleSheet(ThresholdUI.Styles.GaugeLabel)
ThresholdUI.EPLabel:setFontSize(ThresholdUI.metrics.gaugeLabelFontSize)
ThresholdUI.EPLabel:echo(nil, "nocolor", nil)

function ThresholdUI:UpdateVitals()
  if gmcp.Char.Vitals.hp then
    self.Vitals.hp = tonumber(gmcp.Char.Vitals.hp)
  end

  if gmcp.Char.Vitals.maxhp then
    self.Vitals.maxhp = tonumber(gmcp.Char.Vitals.maxhp)
  end

  if self.Vitals.hp and self.Vitals.maxhp then
    self:SetBarValue(self.HPBar, self.Vitals.hp, self.Vitals.maxhp)
  end

  if gmcp.Char.Vitals.sp then
    self.Vitals.sp = tonumber(gmcp.Char.Vitals.sp)
  end

  if gmcp.Char.Vitals.maxsp then
    self.Vitals.maxsp = tonumber(gmcp.Char.Vitals.maxsp)
  end

  if self.Vitals.sp and self.Vitals.maxsp then
    self:SetBarValue(self.SPBar, self.Vitals.sp, self.Vitals.maxsp)
  end

  if gmcp.Char.Vitals.ep then
    self.Vitals.ep = tonumber(gmcp.Char.Vitals.ep)
  end

  if gmcp.Char.Vitals.maxep then
    self.Vitals.maxep = tonumber(gmcp.Char.Vitals.maxep)
  end

  if self.Vitals.ep and self.Vitals.maxep then
    self:SetBarValue(self.EPBar, self.Vitals.ep, self.Vitals.maxep)
  end
end

function ThresholdUI:Afflictions_Add()
  local aff = gmcp.Char.Afflictions.Add

  if aff[1] == "stun" or aff[1] == "immobile" then
    self.HPBar:setStyleSheet(self.Styles.HPFrontStunned)
    self.SPBar:setStyleSheet(self.Styles.SPFrontStunned)
    self.EPBar:setStyleSheet(self.Styles.EPFrontStunned)
  end
end

function ThresholdUI:Afflictions_Remove()
  local aff = gmcp.Char.Afflictions.Remove

  if aff == "stun" or aff == "immobile" then
    self.HPBar:setStyleSheet(self.Styles.HPFrontNormal)
    self.SPBar:setStyleSheet(self.Styles.SPFrontNormal)
    self.EPBar:setStyleSheet(self.Styles.EPFrontNormal)
  end
end
