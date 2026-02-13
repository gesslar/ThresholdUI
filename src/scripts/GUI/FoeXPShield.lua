-- This module is responsible for displaying the foe, xp, and shielding bars.

-- Foe, XP, etc
ThresholdUI.OtherBox = ThresholdUI.OtherBox or Geyser.VBox:new({
  name = "OtherBox"
}, ThresholdUI.BarBox)

-- Foe
ThresholdUI.FoeContainer = ThresholdUI.FoeContainer or Geyser.Container:new({
  name = "FoeContainer",
  x = 0,
  y = 0,
  height = "100%",
  width = "100%"
}, ThresholdUI.OtherBox);

ThresholdUI.FoeBar = ThresholdUI.FoeBar or Geyser.Gauge:new({
  name = "FoeBar",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%"
}, ThresholdUI.FoeContainer)

ThresholdUI.FoeBar:setStyleSheet(
  ThresholdUI.Styles.FoeFrontNormal,
  ThresholdUI.Styles.FoeBack,
  ThresholdUI.Styles.GaugeText
)

ThresholdUI.FoeBar.text:setFontSize(ThresholdUI.metrics.gaugeFontSize)
ThresholdUI.FoeBar.text:echo(nil, "nocolor", nil)

ThresholdUI.FoeLabel = ThresholdUI.FoeLabel or Geyser.Label:new({
  name = "FoeLabel",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
  message = "Foe"
}, ThresholdUI.FoeContainer)

ThresholdUI.FoeLabel:setStyleSheet(ThresholdUI.Styles.GaugeLabel)
ThresholdUI.FoeLabel:setFontSize(ThresholdUI.metrics.gaugeLabelFontSize)
ThresholdUI.FoeLabel:echo(nil, "nocolor", nil)

ThresholdUI.FoeFoeLabel = ThresholdUI.FoeFoeLabel or Geyser.Label:new({
  name = "FoeFoeLabel",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
}, ThresholdUI.FoeContainer)

ThresholdUI.FoeFoeLabel:setStyleSheet(ThresholdUI.Styles.FoeFoeLabelStyle)
ThresholdUI.FoeFoeLabel:setFontSize(ThresholdUI.metrics.gaugeLabelFontSize)
ThresholdUI.FoeFoeLabel:echo(nil, "nocolor", nil)

-- XP
ThresholdUI.XPContainer = ThresholdUI.XPContainer or Geyser.Container:new({
  name = "XPContainer",
  x = 0,
  y = 0,
  height = "100%",
  width = "100%"
}, ThresholdUI.OtherBox);

ThresholdUI.XPBar = ThresholdUI.XPBar or Geyser.Gauge:new({
  name = "XPBar",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%"
}, ThresholdUI.XPContainer)

ThresholdUI.XPBar:setStyleSheet(
  ThresholdUI.Styles.XPFrontNormal,
  ThresholdUI.Styles.XPBack,
  ThresholdUI.Styles.GaugeText
)
ThresholdUI.XPBar.text:setFontSize(ThresholdUI.metrics.gaugeFontSize)
ThresholdUI.XPBar.text:echo(nil, "nocolor", nil)

ThresholdUI.XPLabel = ThresholdUI.XPLabel or Geyser.Label:new({
  name = "XPLabel",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
  message = "XP"
}, ThresholdUI.XPContainer)

ThresholdUI.XPLabel:setStyleSheet(ThresholdUI.Styles.GaugeLabel)
ThresholdUI.XPLabel:setFontSize(ThresholdUI.metrics.gaugeLabelFontSize)
ThresholdUI.XPLabel:echo(nil, "nocolor", nil)

-- Shielding
ThresholdUI.ShieldContainer = ThresholdUI.ShieldContainer or Geyser.Container:new({
  name = "ShieldContainer",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
}, ThresholdUI.OtherBox);

ThresholdUI.ShieldBar = ThresholdUI.ShieldBar or Geyser.Gauge:new({
  name = "ShieldBar",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%"
}, ThresholdUI.ShieldContainer)

ThresholdUI.ShieldBar:setStyleSheet(
  ThresholdUI.Styles.ShieldFrontNormal,
  ThresholdUI.Styles.ShieldBack,
  ThresholdUI.Styles.GaugeText
)

ThresholdUI.ShieldBar.text:setFontSize(ThresholdUI.metrics.gaugeFontSize)
ThresholdUI.ShieldBar.text:echo(nil, "nocolor", nil)

ThresholdUI.ShieldLabel = ThresholdUI.ShieldLabel or Geyser.Label:new({
  name = "ShieldLabel",
  x = 0,
  y = 0,
  width = "100%",
  height = "100%",
  message = "Shielding"
}, ThresholdUI.ShieldContainer)

ThresholdUI.ShieldLabel:setStyleSheet(ThresholdUI.Styles.GaugeLabel)
ThresholdUI.ShieldLabel:setFontSize(ThresholdUI.metrics.gaugeLabelFontSize)
ThresholdUI.ShieldLabel:echo(nil, "nocolor", nil)
ThresholdUI.ShieldContainer:hide()

function ThresholdUI:UpdateXP()
  if gmcp.Char.Status.tnl == nil then return end

  self.XPBar:setValue(
    tonumber(gmcp.Char.Status.tnl), 100, f("{gmcp.Char.Status.tnl}%")
  )
end

function ThresholdUI:UpdateShielding()
  if gmcp.Char.Shielding == nil then
    return
  end

  local shielding = tonumber(gmcp.Char.Shielding)
  if not shielding or shielding < 0 then
    self.ShieldContainer:hide()
  else
    self.ShieldContainer:show()
  end

  self.ShieldBar:setValue(shielding, 100, f("{shielding}%"))
end

function ThresholdUI:UpdateFoe()
  if gmcp.Char.Status.name == nil then return end
  if gmcp.Char.Status.foe_name == nil then return end
  if gmcp.Char.Status.foe_foe_name == nil then return end
  if gmcp.Char.Status.foe_health == nil then return end

  local name = gmcp.Char.Status.name
  local foe = gmcp.Char.Status.foe_name
  local foefoe = gmcp.Char.Status.foe_foe_name
  local health = tonumber(gmcp.Char.Status.foe_health)
  local foetext = ""

  if foe ~= "none" then
    self.FoeLabel:echo(foe)
    self.FoeLabel:setStyleSheet(self.Styles.GaugeLabelCombat)
  else
    self.FoeLabel:echo("Foe")
    self.FoeLabel:setStyleSheet(self.Styles.GaugeLabel)
  end

  self.FoeFoeLabel:echo(foefoe)
  if foefoe == "none" or foefoe == name then
    self.FoeFoeLabel:hide()
  else
    self.FoeFoeLabel:show()
  end

  self:SetBarValue(self.FoeBar, health, 100, foetext)
  -- self.FoeBar:setValue(50, 100, foetext)
end
