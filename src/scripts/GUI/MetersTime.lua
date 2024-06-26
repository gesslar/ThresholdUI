ThresholdUI.RightBox = ThresholdUI.RightBox or
    Geyser.HBox:new({
        name = "RightBox",
        width = 140,
        h_policy = Geyser.Fixed
    }, ThresholdUI.BarBox)

-- Meters
ThresholdUI.MetersBox = ThresholdUI.MetersBox or
    Geyser.HBox:new({
        name = "MetersBox",
        width = 40,
        h_policy = Geyser.Fixed
    }, ThresholdUI.RightBox)

-- Capacity
ThresholdUI.CapacityBox = ThresholdUI.CapacityBox or
    Geyser.VBox:new({
        name = "CapacityBox"
    }, ThresholdUI.MetersBox);

ThresholdUI.CapacityBar = ThresholdUI.CapacityBar or
    Geyser.Gauge:new({
        name = "CapacityBar",
        orientation = "vertical"
    }, ThresholdUI.CapacityBox)

ThresholdUI.CapacityBar:setStyleSheet([[ margin-left: 2px; ]])
ThresholdUI.CapacityBar.front:setStyleSheet(ThresholdUI.Styles.CapacityFront)
ThresholdUI.CapacityBar.back:setStyleSheet(ThresholdUI.Styles.CapacityBack)

ThresholdUI.CapacityLabel = ThresholdUI.CapacityLabel or
    Geyser.Label:new({
        name = "CapacityLabel",
        height = 15,
        width = "100%",
        v_policy = Geyser.Fixed,
        message = "C"
    }, ThresholdUI.CapacityBox)

ThresholdUI.CapacityLabel:setStyleSheet(ThresholdUI.Styles.CapacityText)
ThresholdUI.CapacityLabel:echo(nil, "nocolor", "bc")
ThresholdUI.CapacityLabel:setFontSize(10)
ThresholdUI.CapacityLabel:setBold(1)

-- Tummy
ThresholdUI.TummyBox = ThresholdUI.TummyBox or
    Geyser.VBox:new({
        name = "TummyBox"
    }, ThresholdUI.MetersBox);

ThresholdUI.TummyBar = ThresholdUI.TummyBar or
    Geyser.Gauge:new({
        name = "TummyBar",
        orientation = "vertical"
    }, ThresholdUI.TummyBox)

ThresholdUI.TummyBar:setStyleSheet([[ margin-left: 2px; ]])
ThresholdUI.TummyBar.front:setStyleSheet(ThresholdUI.Styles.TummyFront)
ThresholdUI.TummyBar.back:setStyleSheet(ThresholdUI.Styles.TummyBack)

ThresholdUI.TummyLabel = ThresholdUI.TummyLabel or
    Geyser.Label:new({
        name = "TummyLabel",
        height = 15,
        width = "100%",
        v_policy = Geyser.Fixed,
        message = "T"
    }, ThresholdUI.TummyBox)

ThresholdUI.TummyLabel:setStyleSheet(ThresholdUI.Styles.TummyText)
ThresholdUI.TummyLabel:echo(nil, "nocolor", "bc")
ThresholdUI.TummyLabel:setFontSize(10)
ThresholdUI.TummyLabel:setBold(1)

-- HealBank
ThresholdUI.HealBankBox = ThresholdUI.HealBankBox or
    Geyser.VBox:new({name = "HealBankBox"}, ThresholdUI.MetersBox);
ThresholdUI.HealBankBar = ThresholdUI.HealBankBar or
    Geyser.Gauge:new({name = "HealBankBar", orientation = "vertical"}, ThresholdUI.HealBankBox)
ThresholdUI.HealBankBar:setStyleSheet([[ margin-left: 2px; ]])
ThresholdUI.HealBankBar.front:setStyleSheet(ThresholdUI.Styles.HealBankFront)
ThresholdUI.HealBankBar.back:setStyleSheet(ThresholdUI.Styles.HealBankBack)
ThresholdUI.HealBankLabel = ThresholdUI.HealBankLabel or
    Geyser.Label:new({
        name = "HealBankLabel",
        height = 15,
        width = "100%",
        v_policy = Geyser.Fixed,
        message = "H"
    },ThresholdUI.HealBankBox)

ThresholdUI.HealBankLabel:setStyleSheet(ThresholdUI.Styles.HealBankText)
ThresholdUI.HealBankLabel:echo(nil, "nocolor", "bc")
ThresholdUI.HealBankLabel:setFontSize(10)
ThresholdUI.HealBankLabel:setBold(1)

-- HealTick
ThresholdUI.HealTickBox = ThresholdUI.HealTickBox or
    Geyser.VBox:new({name = "HealTickBox"}, ThresholdUI.MetersBox);

ThresholdUI.HealTickBar = ThresholdUI.HealTickBar or
    Geyser.Gauge:new({name = "HealTickBar", orientation = "vertical"}, ThresholdUI.HealTickBox)

ThresholdUI.HealTickBar:setStyleSheet([[ margin-left: 2px; ]])
ThresholdUI.HealTickBar.front:setStyleSheet(ThresholdUI.Styles.HealTickFront)
ThresholdUI.HealTickBar.back:setStyleSheet(ThresholdUI.Styles.HealTickBack)

ThresholdUI.HealTickLabel = ThresholdUI.HealTickLabel or
    Geyser.Label:new({
        name = "HealTickLabel",
        height = 15,
        width = "100%",
        v_policy = Geyser.Fixed,
        message = "R"
    }, ThresholdUI.HealTickBox)

ThresholdUI.HealTickLabel:setStyleSheet(ThresholdUI.Styles.HealTickText)
ThresholdUI.HealTickLabel:echo(nil, "nocolor", "bc")
ThresholdUI.HealTickLabel:setFontSize(10)
ThresholdUI.HealTickLabel:setBold(1)

-- Breath bar
-- ThresholdUI.BreathBox = ThresholdUI.BreathBox or Geyser.VBox:new({
-- name = "BreathBox",
-- }, ThresholdUI.MetersBox);
--
-- ThresholdUI.BreathBar = ThresholdUI.BreathBar or Geyser.Gauge:new({
-- name="BreathBar",
-- orientation = "vertical"
-- }, ThresholdUI.BreathBox)
-- ThresholdUI.BreathBar:setStyleSheet([[ margin-left: 2px; ]])
-- ThresholdUI.BreathBar.front:setStyleSheet(ThresholdUI.Styles.BreathFront)
-- ThresholdUI.BreathBar.back:setStyleSheet(ThresholdUI.Styles.BreathBack)
--
-- ThresholdUI.BreathLabel = ThresholdUI.BreathLabel or Geyser.Label:new({
-- name = "BreathLabel",
-- height = 15,
-- width  = "100%",
-- v_policy = Geyser.Fixed,
-- message = "B"
-- }, ThresholdUI.BreathBox)
-- ThresholdUI.BreathLabel:setStyleSheet(ThresholdUI.Styles.BreathText)
-- ThresholdUI.BreathLabel:echo(nil, "nocolor", "bc")
-- ThresholdUI.BreathLabel:setFontSize(10)
-- ThresholdUI.BreathLabel:setBold(1)

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

-- function ThresholdUI:UpdateBreath()
-- if gmcp.Char.Status.breath == nil then return end
-- self.BreathBar:setValue(tonumber(gmcp.Char.Status.breath), 100)
-- end

-- Clock
ThresholdUI.DateTimeBox = ThresholdUI.DateTimeBox or
    Geyser.VBox:new({
        name = "TimeBox",
        width = 100, height = ThresholdUI.metrics.height, h_policy = Geyser.Fixed
    }, ThresholdUI.RightBox)

ThresholdUI.DateLabel = ThresholdUI.DateLabel or
    Geyser.Label:new({
        name = "DateLabel",
        font = "Bitstream Vera Sans Mono", fontSize = 11, message = "This is Date"
    }, ThresholdUI.DateTimeBox)

ThresholdUI.DateLabel:setStyleSheet(ThresholdUI.Styles.DateTimeLabel)

ThresholdUI.DayLabel = ThresholdUI.DayLabel or
    Geyser.Label:new({
        name = "DayLabel",
        font = "Bitstream Vera Sans Mono", fontSize = 11, message = "This is Time"
    }, ThresholdUI.DateTimeBox)

ThresholdUI.DayLabel:setStyleSheet(ThresholdUI.Styles.DateTimeLabel)

ThresholdUI.TimeLabel = ThresholdUI.TimeLabel or
    Geyser.Label:new({
        name = "TimeLabel",
        font = "Bitstream Vera Sans Mono", fontSize = 11, message = "This is Time"
    }, ThresholdUI.DateTimeBox)

ThresholdUI.TimeLabel:setStyleSheet(ThresholdUI.Styles.DateTimeLabel)

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
    timemess = f"{timeAsString}{suffix} Toll"
    self.DateLabel:echo(datemess, "nocolor", "c")
    self.DayLabel:echo(datetime.weekday, "nocolor", "c")
    self.TimeLabel:echo(timemess, "nocolor", "c")
end

function ThresholdUI:startTime()
    registerNamedTimer(self.AppName, self.AppName .. ".Time", 1, function() self:refreshTime() end, true)
end

function ThresholdUI:stopTime()
    deleteNamedTimer(self.AppName, self.AppName .. "Time")
end

ThresholdUI:startTime()
