-- Re-applies every size in the UI after ThresholdUI:ComputeMetrics, so the
-- font size can change without rebuilding anything. Also run once at the end
-- of the build so both paths end up identical.
function ThresholdUI:ApplySizes()
  self:ComputeMetrics()

  local m = self.metrics

  -- The bar and the strip above it (resting or psion feedback)
  self.MainContainer:move(2, -(m.height - 2))
  self.MainContainer:resize("100%", m.height - 2)

  for _, strip in ipairs({ self.InactiveContainer, self.FeedbackBox }) do
    strip:move(0, -(m.height + m.inactiveHeight) + 2)
    strip:resize("100%", m.inactiveHeight)
  end

  if self.InactiveContainer.hidden and self.FeedbackBox.hidden then
    setBorderBottom(m.height)
  else
    setBorderBottom(m.height + m.inactiveHeight)
  end

  self.InactiveLabel:setFontSize(m.inactiveFontSize)

  -- Gauges: the number on the bar and the name at its left
  for _, name in ipairs({ "HP", "SP", "EP", "Foe", "XP", "Shield" }) do
    self[name .. "Bar"].text:setFontSize(m.gaugeFontSize)
    self[name .. "Label"]:setFontSize(m.gaugeLabelFontSize)
  end
  self.FoeFoeLabel:setFontSize(m.gaugeLabelFontSize)

  self.VitalsBox:resize(m.vitalsWidth, nil)

  -- Meters
  self.MetersBox:resize(m.metersWidth, nil)

  for _, name in ipairs({ "Capacity", "Tummy", "HealBank", "HealTick" }) do
    local label = self[name .. "Label"]

    label:resize(nil, m.maxDim.height)
    label:setFontSize(m.meterFontSize)
    self[name .. "Box"]:organize()
  end

  -- Clock
  self.DateTimeBg:resize(m.dateTimeWidth, nil)
  self.DateLabel:setFontSize(m.dateFontSize)
  self.DayLabel:setFontSize(m.dayFontSize)
  self.TimeLabel:setFontSize(m.hourFontSize)
  self.Devotion:setFontSize(m.devotionFontSize)

  local rightWidth = m.metersWidth
  if self.Prefs.TimeBox ~= false then
    rightWidth = rightWidth + m.dateTimeWidth
  end
  self.RightBox:resize(rightWidth, nil)

  self.MetersBox:organize()
  self.RightBox:organize()
  self.BarBox:organize()

  -- Re-echo the clock at its new size
  self.LastTimeText = nil
  if self.Prefs.TimeBox ~= false then
    self:refreshTime()
  end
end

-- /tui size [<n>|default]
function ThresholdUI:SetSize(arg)
  local current = self.Prefs.FontSize or self.PrefsDefaults.FontSize

  if arg == nil then
    echo("Font size is " .. current .. " (default " .. self.PrefsDefaults.FontSize .. ").\n")
    return
  end

  local size
  if arg == "default" then
    size = self.PrefsDefaults.FontSize
  else
    size = tonumber(arg)
  end

  if size == nil or size ~= math.floor(size) or size < 6 or size > 40 then
    echo("Syntax: /tui size [<6-40>|default]\n")
    return
  end

  self:SetPref("FontSize", size)
  self:ApplySizes()
  echo("Font size set to " .. size .. ".\n")
end

ThresholdUI:ApplySizes()
