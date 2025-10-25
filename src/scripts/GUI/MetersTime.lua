-- Let's find out how big everything is!
local numMeters = 4
local metersBoxWidth = numMeters * (ThresholdUI.metrics.devotionDim.width)
local DateTimeBgWidth = ThresholdUI.metrics.devotionDim.width * ThreshTime.config.longestDevotion

local RightBoxWidth = metersBoxWidth + DateTimeBgWidth

ThresholdUI.RightBox = ThresholdUI.RightBox or Geyser.HBox:new({
  name = "RightBox",
  width = RightBoxWidth,
  h_policy = Geyser.Fixed
}, ThresholdUI.BarBox)

-- We need to know how wide to make the meters, since that box is going to be
-- statically sized and the time stuff will be auto.


-- Meters
ThresholdUI.MetersBox = ThresholdUI.MetersBox or Geyser.HBox:new({
  name = "MetersBox",
  width = metersBoxWidth,
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
  if gmcp.Char.Status.capacity == nil then return end
  if gmcp.Char.Status.max_capacity == nil then return end

  self.CapacityBar:setValue(
    tonumber(gmcp.Char.Status.max_capacity) - tonumber(gmcp.Char.Status.capacity),
    tonumber(gmcp.Char.Status.max_capacity)
  )
end

function ThresholdUI:UpdateTummy()
  if gmcp.Char.Status.tummy == nil then return end

  self.TummyBar:setValue(tonumber(gmcp.Char.Status.tummy), 100)
end

function ThresholdUI:UpdateHealBank()
  if gmcp.Char.Status.hb == nil then return end

  self.HealBankBar:setValue(tonumber(gmcp.Char.Status.hb), 100)
end

function ThresholdUI:UpdateHealTick()
  if gmcp.Char.Status.heal_tick == nil then return end

  local current = gmcp.Char.Status.heal_tick[1]
  local max = gmcp.Char.Status.heal_tick[2]

  self.HealTickBar:setValue(current - 1, max - 1)
end

function ThresholdUI:ToggleHealTick(event, arg, silent)
  if arg == "on" then
    self.MetersBox:add(self.HealTickBox)
    self.HealTickBox:show()

    if silent ~= true then
      echo("Regen tick gauge enabled.\n")
    end

    self.Prefs.HealTick = true
    self:SavePrefs()

  elseif arg == "off" then
    self.HealTickBox:hide()
    self.MetersBox:remove(self.HealTickBox)
    self.MetersBox:organize()
    self.Prefs.HealTick = false
    self:SavePrefs()

    if silent ~= true then
      echo("Regen tick gauge disabled.\n")
    end

  else
    echo("Syntax: regen <on|off>\n")
  end
end

-- Clock

-- Background label to prevent bleeding colours
ThresholdUI.DateTimeBg = ThresholdUI.DateTimeBg or Geyser.Label:new({
  name = "DateTimeBg",
  width = DateTimeBgWidth, height = ThresholdUI.metrics.height,
  h_policy = Geyser.Fixed,
  stylesheet = ThresholdUI.Styles.DateTimeLabel
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
    self.DateTimeBg:resize(DateTimeBgWidth, nil)
    self.DateTimeBg:show()
    self.RightBox:add(self.DateTimeBg)
    self.RightBox:resize(self.MetersBox.get_width() + DateTimeBgWidth, nil)
    self.RightBox:move(-(self.MetersBox.get_width() + DateTimeBgWidth), nil)
    self.BarBox:organize()
    self:startTime()

    if silent ~= true then
        echo("Time box enabled.\n")
    end

    self.Prefs.TimeBox = true
    self:SavePrefs()

  elseif arg == "off" then
    self.DateTimeBg:hide()
    self.RightBox:remove(self.DateTimeBg)
    self.RightBox:organize()
    self.RightBox:resize(self.MetersBox.get_width(), nil)
    self.RightBox:move(-self.MetersBox.get_width(), nil)
    self.BarBox:organize()
    self:stopTime()
    self.Prefs.TimeBox = false
    self:SavePrefs()

    if silent ~= true then
        echo("Time box disabled.\n")
    end

  else
    echo("Syntax: timebox <on|off>\n")
  end
end

function ThresholdUI:refreshTime()
  local datetime = ThreshTime:getTime()
  local datemess = f("{datetime.month}/{datetime.day}/{datetime.year}")
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

  timemess = f"{timeAsString}{suffix} toll"
  self.DateLabel:echo(datemess, "nocolor", nil)
  self.DayLabel:echo(datetime.weekday, "nocolor", nil)
  self.TimeLabel:echo(timemess, "nocolor", nil)
  self.Devotion:echo(datetime.devotion, "nocolor", nil)
end

function ThresholdUI:startTime()
  registerNamedTimer(self.AppName, self.Timers.Time, 1, function() self:refreshTime() end, true)
end

function ThresholdUI:stopTime()
  deleteNamedTimer(self.AppName, self.Timers.Time)
end

ThresholdUI:startTime()
