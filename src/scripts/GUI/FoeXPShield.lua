-- Foe, XP, etc
ThresholdUI.OtherBox = ThresholdUI.OtherBox or Geyser.VBox:new({name = "OtherBox"}, ThresholdUI.BarBox)

-- Foe
ThresholdUI.FoeContainer = ThresholdUI.FoeContainer or
    Geyser.Container:new({
        name = "FoeContainer",
        x = 0, y = 0, height = "100%", width = "100%"
    }, ThresholdUI.OtherBox);

ThresholdUI.FoeBar = ThresholdUI.FoeBar or
    Geyser.Gauge:new({
        name = "FoeBar",
        x = 0, y = 0, width = "100%", height = "100%"
    }, ThresholdUI.FoeContainer)

ThresholdUI.FoeBar.front:setStyleSheet(ThresholdUI.Styles.FoeFrontNormal)
ThresholdUI.FoeBar.back:setStyleSheet(ThresholdUI.Styles.FoeBack)
ThresholdUI.FoeBar.text:setStyleSheet(ThresholdUI.Styles.GaugeText)
ThresholdUI.FoeBar.text:setFontSize(11)
ThresholdUI.FoeBar.text:echo(nil, "nocolor", "bc")
ThresholdUI.FoeBar.text:setAlignment("right")

ThresholdUI.FoeLabel = ThresholdUI.FoeLabel or
    Geyser.Label:new({
        name = "FoeLabel",
        x = 0, y = 0, width = "100%", height = "100%", message = "Foe"
    }, ThresholdUI.FoeContainer)

ThresholdUI.FoeLabel:setStyleSheet(ThresholdUI.Styles.InnerLabelStyle)
ThresholdUI.FoeLabel:setFontSize(ThresholdUI.metrics.gauge_label_font_size)

ThresholdUI.FoeFoeLabel = ThresholdUI.FoeFoeLabel or
    Geyser.Label:new({
        name = "FoeFoeLabel",
        x = 0, y = 0, width = "100%", height = "100%", message = "Foe name"
    }, ThresholdUI.FoeContainer)

ThresholdUI.FoeFoeLabel:setStyleSheet(ThresholdUI.Styles.FoeFoeLabelStyle)
ThresholdUI.FoeFoeLabel:setFontSize(ThresholdUI.metrics.gauge_label_font_size)
ThresholdUI.FoeFoeLabel:hide()

-- XP
ThresholdUI.XPContainer = ThresholdUI.XPContainer or
    Geyser.Container:new({
        name = "XPContainer",
        x = 0, y = 0, height = "100%", width = "100%"
    }, ThresholdUI.OtherBox);

ThresholdUI.XPBar = ThresholdUI.XPBar or
    Geyser.Gauge:new({
        name = "XPBar",
        x = 0, y = 0, width = "100%", height = "100%"
    }, ThresholdUI.XPContainer)

ThresholdUI.XPBar.front:setStyleSheet(ThresholdUI.Styles.XPFrontNormal)
ThresholdUI.XPBar.back:setStyleSheet(ThresholdUI.Styles.XPBack)
ThresholdUI.XPBar.text:setStyleSheet(ThresholdUI.Styles.GaugeText)
ThresholdUI.XPBar.text:setFontSize(ThresholdUI.metrics.gauge_font_size)
ThresholdUI.XPBar.text:echo(nil, "nocolor", "bc")

ThresholdUI.XPLabel = ThresholdUI.XPLabel or
    Geyser.Label:new({
        name = "XPLabel",
        x = 0, y = 0, width = "100%", height = "100%", message = "XP"
    },ThresholdUI.XPContainer)

ThresholdUI.XPLabel:setStyleSheet(ThresholdUI.Styles.InnerLabelStyle)
ThresholdUI.XPLabel:setFontSize(ThresholdUI.metrics.gauge_label_font_size)

-- Shielding
ThresholdUI.ShieldContainer = ThresholdUI.ShieldContainer or
    Geyser.Container:new({
        name = "ShieldContainer",
        x = 0, y = 0, height = "100%", width = "100%"
    }, ThresholdUI.OtherBox);

ThresholdUI.ShieldBar = ThresholdUI.ShieldBar or
    Geyser.Gauge:new({
        name = "ShieldBar",
        x = 0, y = 0, width = "100%", height = "100%"
    }, ThresholdUI.ShieldContainer)

ThresholdUI.ShieldBar.front:setStyleSheet(ThresholdUI.Styles.ShieldFrontNormal)
ThresholdUI.ShieldBar.back:setStyleSheet(ThresholdUI.Styles.ShieldBack)
ThresholdUI.ShieldBar.text:setStyleSheet(ThresholdUI.Styles.GaugeText)
ThresholdUI.ShieldBar.text:setFontSize(ThresholdUI.metrics.gauge_font_size)
ThresholdUI.ShieldBar.text:echo(nil, "nocolor", "bc")

ThresholdUI.ShieldLabel = ThresholdUI.ShieldLabel or
    Geyser.Label:new({
        name = "ShieldLabel",
        x = 0, y = 0, width = "100%", height = "100%", message = "Shield"
    }, ThresholdUI.ShieldContainer)

ThresholdUI.ShieldLabel:setStyleSheet(ThresholdUI.Styles.InnerLabelStyle)
ThresholdUI.ShieldLabel:setFontSize(ThresholdUI.metrics.gauge_label_font_size)
ThresholdUI.ShieldContainer:hide()

function ThresholdUI:UpdateXP()
    if gmcp.Char.Status.tnl == nil then return end

    self.XPBar:setValue(
        tonumber(gmcp.Char.Status.tnl), 100, f("<center>{gmcp.Char.Status.tnl}%</center>")
    )
end

function ThresholdUI:UpdateShielding()
    if gmcp.Char.Status.Shielding == nil then return end

    local shielding = tonumber(gmcp.Char.Shielding)
    if not shielding or shielding < 0 then
        self.ShieldContainer:hide()
    else
        self.ShieldContainer:show()
    end
    self.ShieldBar:setValue(shielding, 100, f("<center>{shielding}%</center>"))
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
    else
        self.FoeLabel:echo("Foe")
    end

    self.FoeFoeLabel:echo(foefoe)
    if foefoe == "none" or foefoe == name then
        self.FoeFoeLabel:hide()
    else
        self.FoeFoeLabel:show()
    end

    self.FoeBar:setValue(health, 100, foetext)
end
