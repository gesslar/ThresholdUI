-- Meters and clock, sized from ThresholdUI:ComputeMetrics
ThresholdUI.RightBox = ThresholdUI.RightBox or Geyser.HBox:new({
  name = "RightBox",
  width = ThresholdUI.metrics.metersWidth + ThresholdUI.metrics.dateTimeWidth,
  h_policy = Geyser.Fixed
}, ThresholdUI.BarBox)

-- Meters
ThresholdUI.MetersBox = ThresholdUI.MetersBox or Geyser.HBox:new({
  name = "MetersBox",
  width = ThresholdUI.metrics.metersWidth,
  h_policy = Geyser.Fixed
}, ThresholdUI.RightBox)

-- Capacity
ThresholdUI.CapacityBox = ThresholdUI.CapacityBox or Geyser.VBox:new({
  name = "CapacityBox"
}, ThresholdUI.MetersBox);

ThresholdUI.CapacityBar = ThresholdUI.CapacityBar or Geyser.Gauge:new({
  name = "CapacityBar",
  orientation = "vertical"
}, ThresholdUI.CapacityBox)

ThresholdUI.CapacityBar:setStyleSheet(
  ThresholdUI.Styles.MeterFront,
  ThresholdUI.Styles.MeterBack
)

ThresholdUI.CapacityLabel = ThresholdUI.CapacityLabel or Geyser.Label:new({
  name = "CapacityLabel",
  width = "100%", height = ThresholdUI.metrics.maxDim.height,
  v_policy = Geyser.Fixed,
  message = "C",
  font = ThresholdUI.Styles.MeterFontName, fontSize = ThresholdUI.metrics.meterFontSize,
}, ThresholdUI.CapacityBox)
ThresholdUI.CapacityLabel:setStyleSheet(ThresholdUI.Styles.MeterLabel)
ThresholdUI.CapacityLabel:echo(nil, "nocolor", nil)

-- Tummy
ThresholdUI.TummyBox = ThresholdUI.TummyBox or Geyser.VBox:new({
  name = "TummyBox"
}, ThresholdUI.MetersBox);

ThresholdUI.TummyBar = ThresholdUI.TummyBar or Geyser.Gauge:new({
  name = "TummyBar",
  orientation = "vertical"
}, ThresholdUI.TummyBox)

ThresholdUI.TummyBar:setStyleSheet(
  ThresholdUI.Styles.MeterFront,
  ThresholdUI.Styles.MeterBack
)

ThresholdUI.TummyLabel = ThresholdUI.TummyLabel or Geyser.Label:new({
  name = "TummyLabel",
  width = "100%", height = ThresholdUI.metrics.maxDim.height,
  v_policy = Geyser.Fixed,
  message = "T",
  font = ThresholdUI.Styles.MeterFontName, fontSize = ThresholdUI.metrics.meterFontSize,
}, ThresholdUI.TummyBox)

ThresholdUI.TummyLabel:setStyleSheet(ThresholdUI.Styles.MeterLabel)
ThresholdUI.TummyLabel:echo(nil, "nocolor", nil)

-- HealBank
ThresholdUI.HealBankBox = ThresholdUI.HealBankBox or Geyser.VBox:new({
  name = "HealBankBox"
}, ThresholdUI.MetersBox);

ThresholdUI.HealBankBar = ThresholdUI.HealBankBar or Geyser.Gauge:new({
  name = "HealBankBar",
  orientation = "vertical"
}, ThresholdUI.HealBankBox)

ThresholdUI.HealBankBar:setStyleSheet(
  ThresholdUI.Styles.MeterFront,
  ThresholdUI.Styles.MeterBack
)

ThresholdUI.HealBankLabel = ThresholdUI.HealBankLabel or Geyser.Label:new({
  name = "HealBankLabel",
  width = "100%", height = ThresholdUI.metrics.maxDim.height,
  v_policy = Geyser.Fixed,
  message = "H",
  font = ThresholdUI.Styles.MeterFontName, fontSize = ThresholdUI.metrics.meterFontSize,
},ThresholdUI.HealBankBox)

ThresholdUI.HealBankLabel:setStyleSheet(ThresholdUI.Styles.MeterLabel)
ThresholdUI.HealBankLabel:echo(nil, "nocolor", nil)

-- HealTick
ThresholdUI.HealTickBox = ThresholdUI.HealTickBox or Geyser.VBox:new({
  name = "HealTickBox"
}, ThresholdUI.MetersBox);

ThresholdUI.HealTickBar = ThresholdUI.HealTickBar or Geyser.Gauge:new({
  name = "HealTickBar",
  orientation = "vertical"
}, ThresholdUI.HealTickBox)

ThresholdUI.HealTickBar:setStyleSheet(
  ThresholdUI.Styles.MeterFront,
  ThresholdUI.Styles.MeterBack
)

ThresholdUI.HealTickLabel = ThresholdUI.HealTickLabel or Geyser.Label:new({
  name = "HealTickLabel",
  width = "100%", height = ThresholdUI.metrics.maxDim.height,
  v_policy = Geyser.Fixed,
  message = "R",
  font = ThresholdUI.Styles.MeterFontName, fontSize = ThresholdUI.metrics.meterFontSize,
}, ThresholdUI.HealTickBox)

ThresholdUI.HealTickLabel:setStyleSheet(ThresholdUI.Styles.MeterLabel)
ThresholdUI.HealTickLabel:echo(nil, "nocolor", nil)

function ThresholdUI:UpdateCapacity()
  local capacity = self:StatusNumber("capacity")
  local max_capacity = self:StatusNumber("max_capacity")
  if capacity == nil or max_capacity == nil or max_capacity <= 0 then return end

  self.CapacityBar:setValue(max_capacity - capacity, max_capacity)
end

function ThresholdUI:UpdateTummy()
  local tummy = self:StatusNumber("tummy")
  if tummy == nil then return end

  self.TummyBar:setValue(tummy, 100)
end

function ThresholdUI:UpdateHealBank()
  local hb = self:StatusNumber("hb")
  if hb == nil then return end

  self.HealBankBar:setValue(hb, 100)
end

function ThresholdUI:UpdateHealTick()
  local heal_tick = gmcp.Char.Status.heal_tick
  if type(heal_tick) ~= "table" then return end

  local current = tonumber(heal_tick[1])
  local max = tonumber(heal_tick[2])
  if current == nil or max == nil or max <= 1 then return end

  self.HealTickBar:setValue(current - 1, max - 1)
end

-- Stores a preference, only touching the file when the value actually changes
-- (the toggles are re-applied silently on every connection).
function ThresholdUI:SetPref(key, value)
  if self.Prefs[key] == value then return end

  self.Prefs[key] = value
  self:SavePrefs()
end

function ThresholdUI:ToggleHealTick(event, arg, silent)
  if arg == "on" then
    self.MetersBox:add(self.HealTickBox)
    self.HealTickBox:show()

    if silent ~= true then
      echo("Regen tick gauge enabled.\n")
    end

    self:SetPref("HealTick", true)

  elseif arg == "off" then
    self.HealTickBox:hide()
    self.MetersBox:remove(self.HealTickBox)
    self.MetersBox:organize()
    self:SetPref("HealTick", false)

    if silent ~= true then
      echo("Regen tick gauge disabled.\n")
    end

  else
    echo("Syntax: /tui regen [on|off]\n")
  end
end

-- Clock

-- Base label that sizes the clock column within RightBox
ThresholdUI.DateTimeBg = ThresholdUI.DateTimeBg or Geyser.Label:new({
  name = "DateTimeBg",
  width = ThresholdUI.metrics.dateTimeWidth, height = ThresholdUI.metrics.height,
  h_policy = Geyser.Fixed,
  stylesheet = ThresholdUI.Styles.DateTimeBg
}, ThresholdUI.RightBox)

ThresholdUI.DateTimeBox = ThresholdUI.DateTimeBox or Geyser.VBox:new({
  name = "TimeBox",
  x = 0, y = 0,
  width = "100%", height = "100%"
}, ThresholdUI.DateTimeBg)

ThresholdUI.DateLabel = ThresholdUI.DateLabel or Geyser.Label:new({
  name = "DateLabel",
  font = ThresholdUI.Styles.DateTimeFont, fontSize = ThresholdUI.metrics.dateFontSize,
  stylesheet = ThresholdUI.Styles.DateTimeLabel
}, ThresholdUI.DateTimeBox)

ThresholdUI.DayLabel = ThresholdUI.DayLabel or Geyser.Label:new({
  name = "DayLabel",
  font = ThresholdUI.Styles.DateTimeFont, fontSize = ThresholdUI.metrics.dayFontSize,
  stylesheet = ThresholdUI.Styles.DateTimeLabel
}, ThresholdUI.DateTimeBox)

ThresholdUI.TimeLabel = ThresholdUI.TimeLabel or Geyser.Label:new({
  name = "TimeLabel",
  font = ThresholdUI.Styles.DateTimeFont, fontSize = ThresholdUI.metrics.hourFontSize,
  stylesheet = ThresholdUI.Styles.DateTimeLabel
}, ThresholdUI.DateTimeBox)

ThresholdUI.Devotion = ThresholdUI.Devotion or Geyser.Label:new({
  name = "DevotionLabel",
  font = ThresholdUI.Styles.DateTimeFont, fontSize = ThresholdUI.metrics.devotionFontSize,
  stylesheet = ThresholdUI.Styles.DateTimeLabel
}, ThresholdUI.DateTimeBox)

function ThresholdUI:ToggleTimeBox(event, arg, silent)
  if arg == "on" then
    self.DateTimeBg:resize(self.metrics.dateTimeWidth, nil)
    self.DateTimeBg:show()
    self.RightBox:add(self.DateTimeBg)
    -- BarBox:organize() positions RightBox, so only its width needs setting
    self.RightBox:resize(self.metrics.metersWidth + self.metrics.dateTimeWidth, nil)
    self.BarBox:organize()
    self:startTime()

    if silent ~= true then
        echo("Time box enabled.\n")
    end

    self:SetPref("TimeBox", true)

  elseif arg == "off" then
    self.DateTimeBg:hide()
    self.RightBox:remove(self.DateTimeBg)
    self.RightBox:organize()
    self.RightBox:resize(self.metrics.metersWidth, nil)
    self.BarBox:organize()
    self:stopTime()
    self:SetPref("TimeBox", false)

    if silent ~= true then
        echo("Time box disabled.\n")
    end

  else
    echo("Syntax: /tui datetime [on|off]\n")
  end
end

function ThresholdUI:refreshTime()
  local datetime = ThreshTime:getTime()
  local datemess = datetime.month .. "/" .. datetime.day .. "/" .. datetime.year
  local timeAsString = tostring(datetime.hour)
  local timemess
  local suffix

  if datetime.hour == 0 then
    suffix = "th"
  elseif datetime.hour == 1 then
    suffix = "st"
  elseif datetime.hour == 2 then
    suffix = "nd"
  elseif datetime.hour == 3 then
    suffix = "rd"
  elseif datetime.hour >= 4 and datetime.hour <= 20 then
    suffix = "th"
  elseif datetime.hour == 21 then
    suffix = "st"
  elseif datetime.hour == 22 then
    suffix = "nd"
  elseif datetime.hour == 23 then
    suffix = "rd"
  end

  timemess = timeAsString .. suffix .. " toll"

  -- This runs every second, but the toll only changes every few real minutes,
  -- so only re-echo the labels whose text actually changed.
  local last = self.LastTimeText or {}
  local function update(label, key, text)
    if last[key] == text then return end

    label:echo(text, "nocolor", nil)
    last[key] = text
  end

  update(self.DateLabel, "date", datemess)
  update(self.DayLabel, "day", datetime.weekday)
  update(self.TimeLabel, "time", timemess)
  update(self.Devotion, "devotion", datetime.devotion)
  self.LastTimeText = last
end

function ThresholdUI:startTime()
  registerNamedTimer(self.AppName, self.Timers.Time, 1, function() self:refreshTime() end, true)
end

function ThresholdUI:stopTime()
  deleteNamedTimer(self.AppName, self.Timers.Time)
end

-- Apply the saved preferences as the UI is built, so they hold offline too
if ThresholdUI.Prefs.HealTick == false then
  ThresholdUI:ToggleHealTick(nil, "off", true)
end

if ThresholdUI.Prefs.TimeBox == false then
  ThresholdUI:ToggleTimeBox(nil, "off", true)
else
  ThresholdUI:startTime()
end
