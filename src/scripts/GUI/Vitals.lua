-- Char.Vitals information
ThresholdUI.VitalsBox = ThresholdUI.VitalsBox or Geyser.VBox:new({
  name = "VitalsBox",
  width = ThresholdUI.metrics.vitalsWidth,
  h_policy = Geyser.Fixed
}, ThresholdUI.BarBox)

-- HP
ThresholdUI.HPContainer = ThresholdUI.HPContainer or Geyser.Container:new({
  name = "HPContainer",
  x = 0, y = 0,
  width = "100%", height = "100%",
}, ThresholdUI.VitalsBox);

ThresholdUI.HPBar = ThresholdUI.HPBar or Geyser.Gauge:new({
  name = "HPBar",
  x = 0, y = 0,
  width = "100%", height = "100%",
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
  x = 0, y = 0,
  width = "100%", height = "100%",
  message = "HP"
}, ThresholdUI.HPContainer)

ThresholdUI.HPLabel:setStyleSheet(ThresholdUI.Styles.GaugeLabel)
ThresholdUI.HPLabel:setFontSize(ThresholdUI.metrics.gaugeLabelFontSize)
ThresholdUI.HPLabel:echo(nil, "nocolor", nil)

-- SP
ThresholdUI.SPContainer = ThresholdUI.SPContainer or Geyser.Container:new({
  name = "SPContainer",
  x = 0, y = 0,
  width = "100%", height = "100%",
}, ThresholdUI.VitalsBox);

ThresholdUI.SPBar = ThresholdUI.SPBar or Geyser.Gauge:new({
  name = "SPBar",
  x = 0, y = 0,
  width = "100%", height = "100%"
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
  x = 0, y = 0,
  width = "100%", height = "100%",
  message = "SP"
}, ThresholdUI.SPContainer)

ThresholdUI.SPLabel:setStyleSheet(ThresholdUI.Styles.GaugeLabel)
ThresholdUI.SPLabel:setFontSize(ThresholdUI.metrics.gaugeLabelFontSize)
ThresholdUI.SPLabel:echo(nil, "nocolor", nil)

-- EP
ThresholdUI.EPContainer = ThresholdUI.EPContainer or Geyser.Container:new({
  name = "EPContainer",
  x = 0, y = 0,
  width = "100%", height = "100%",
}, ThresholdUI.VitalsBox);

ThresholdUI.EPBar = ThresholdUI.EPBar or Geyser.Gauge:new({
  name = "EPBar",
  x = 0, y = 0,
  width = "100%", height = "100%"
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
  x = 0, y = 0,
  width = "100%", height = "100%",
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

-- Afflictions that dim the vitals gauges, and which of them are active now.
-- Tracked as a set so that losing one (e.g. immobile) while another is still
-- active (e.g. stun) keeps the gauges dimmed.
--
-- Payload shapes, per the mudlib (adm/daemons/modules/gmcp/Char.c,
-- std/living/handicap.c, std/body/attack.c):
--   Afflictions.Add    { name, expiration }
--   Afflictions.Remove name
--   Afflictions.List   { [name] = expiration, ... }  (the full current set)
ThresholdUI.DimmingAfflictions = { stun = true, immobile = true }
ThresholdUI.ActiveDimming = ThresholdUI.ActiveDimming or {}

function ThresholdUI:RefreshVitalsDimming()
  local front = next(self.ActiveDimming) and "FrontStunned" or "FrontNormal"

  self.HPBar:setStyleSheet(self.Styles["HP" .. front], self.Styles.HPBack, self.Styles.GaugeText)
  self.SPBar:setStyleSheet(self.Styles["SP" .. front], self.Styles.SPBack, self.Styles.GaugeText)
  self.EPBar:setStyleSheet(self.Styles["EP" .. front], self.Styles.EPBack, self.Styles.GaugeText)
end

-- Applies a change to the active set, restyling only if dimmed-ness flipped
function ThresholdUI:UpdateDimming(change)
  local wasDimmed = next(self.ActiveDimming) ~= nil

  change()

  if wasDimmed ~= (next(self.ActiveDimming) ~= nil) then
    self:RefreshVitalsDimming()
  end
end

function ThresholdUI:Afflictions_Add()
  local aff = gmcp.Char.Afflictions.Add
  local name = type(aff) == "table" and aff[1]
  if not self.DimmingAfflictions[name] then return end

  self:UpdateDimming(function() self.ActiveDimming[name] = true end)
end

function ThresholdUI:Afflictions_Remove()
  local name = gmcp.Char.Afflictions.Remove
  if not self.DimmingAfflictions[name] then return end

  self:UpdateDimming(function() self.ActiveDimming[name] = nil end)
end

-- Sent on login and when asked for on connect, so dimming from a stun or
-- immobile that outlasted a reconnect is restored
function ThresholdUI:Afflictions_List()
  local list = gmcp.Char.Afflictions.List
  if type(list) ~= "table" then return end

  self:UpdateDimming(function()
    self.ActiveDimming = {}

    for name in pairs(self.DimmingAfflictions) do
      if list[name] ~= nil then
        self.ActiveDimming[name] = true
      end
    end
  end)
end

-- The gauges were just given their normal styles above, but ActiveDimming
-- survives a reload of this script, so put any dimming back
ThresholdUI:RefreshVitalsDimming()
