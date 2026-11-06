local FontName = "Ubuntu"
local DateTimeFontName = FontName
local Font = "font-family: '" .. FontName .. "';"
local DateTimeFont = "font-family: '" .. DateTimeFontName .. "';"
local MainTextFont = Font
local MainTextColour = "color: rgba(200,200,200,90%);"
local Bold = "font-weight: 500;"
local Left = "qproperty-alignment: 'AlignLeft | AlignVCenter';"
local Center = "qproperty-alignment: 'AlignCenter | AlignVCenter';"
local Right = "qproperty-alignment: 'AlignRight | AlignVCenter';"
-- Opaque so nothing from the console underneath shows through the panel; this
-- is what the old 10% gold looked like over a black console
local MainBackgroundColour = "background-color: rgb(15, 15, 0);"
local MainBorder = "1px solid rgba(224, 173, 45, 10%)"
local GaugeBorder = "border-radius: 3px; border: 1px solid rgba(224, 173, 45, 22%);"
local GaugeMargin = "margin: 2px 3px;"
local MeterBorder = "border-radius: 3px; border: 1px solid rgba(20, 20, 20, 100%);"
local MeterFontName = FontName
local MeterFGColour =
"background: QLinearGradient( x1: 0, y1: 0, x2: 1, y2: 1, stop: 0 #ffddc9, stop: 0.1 #9e6e3a, stop: 0.95 #6a4825, stop: 1 #ffddc9);"
local MeterBGColour = "background: rgba(224, 173, 45, 15%);"
local Transparent = "background-color: rgba(0,0,0,0%);"
local MeterLabel = Transparent .. " color: rgba(224, 173, 45, 100%); " .. Center
local FeedbackBorder = "border-radius: 3px; border: 1px solid rgba(20, 20, 20, 100%);"

ThresholdUI.Styles = ThresholdUI.Styles or {
  FontName = FontName,
  MainContainer = MainBackgroundColour .. " border-top: " .. MainBorder .. "; border-bottom: " .. MainBorder .. ";",

  GaugeLabel = Transparent ..
      " padding-left: 4px; padding-right: 4px; " .. Left .. " " .. MainTextFont .. " " .. MainTextColour,
  GaugeLabelCombat = Transparent ..
      " padding-left: 4px; padding-right: 4px; " .. Left .. " " .. MainTextFont .. " " .. MainTextColour .. " " .. Bold,
  GaugeText = Transparent .. " " .. MainTextColour .. " " .. Font .. " " .. Center .. " " .. Bold,

  HPFrontNormal = "background-color: rgb(164, 25, 25); " .. GaugeBorder .. " " .. GaugeMargin,
  HPFrontStunned = "background-color: rgba(165,0,0, 35%); " .. GaugeBorder .. " " .. GaugeMargin,
  HPBack = "background-color: rgb(32, 5, 5); " .. GaugeBorder .. " " .. GaugeMargin,

  SPFrontNormal = "background-color: rgb(0, 64, 128); " .. GaugeBorder .. " " .. GaugeMargin,
  SPFrontStunned = "background-color: rgba(0, 51, 103, 35%); " .. GaugeBorder .. " " .. GaugeMargin,
  SPBack = "background-color: rgb(44, 48, 50); " .. GaugeBorder .. " " .. GaugeMargin,

  EPFrontNormal = "background-color: rgb(0, 128, 128); " .. GaugeBorder .. " " .. GaugeMargin,
  EPFrontStunned = "background-color: rgba(0, 102, 102, 35%); " .. GaugeBorder .. " " .. GaugeMargin,
  EPBack = "background-color: rgb(0, 51, 51); " .. GaugeBorder .. " " .. GaugeMargin,

  FoeFrontNormal = "background-color: rgb(129,83,0); " .. GaugeBorder .. " " .. GaugeMargin,
  FoeBack = "background-color: rgb(54, 44, 27); " .. GaugeBorder .. " " .. GaugeMargin,
  FoeFoeLabelStyle = MainTextColour ..
      " " .. Font .. " " .. Right .. " " .. Transparent .. " padding-right: 4px; " .. Bold,

  XPFrontNormal = "background-color: rgb(122, 0, 122); " .. GaugeBorder .. " " .. GaugeMargin,
  XPBack = "background-color: rgb(52, 0, 52); " .. GaugeBorder .. " " .. GaugeMargin,

  ShieldFrontNormal = "background-color: rgb(34, 90, 34); " .. GaugeBorder .. " " .. GaugeMargin,
  ShieldBack = "background-color: rgb(0, 26, 0); " .. GaugeBorder .. " " .. GaugeMargin,

  MeterFront = MeterFGColour .. " " .. MeterBorder,
  MeterBack = MeterBGColour .. " " .. MeterBorder,
  MeterLabel = MeterLabel,
  MeterFontName = MeterFontName,

  DateTimeFont = DateTimeFontName,
  -- Layout-only base under the clock: transparent so the panel shows through
  DateTimeBg = Transparent,
  DateTimeLabel = DateTimeFont ..
      " color: rgba(224, 173, 45, 100%); " .. Transparent .. " letter-spacing: 1px; " .. Center,

  CommandLine = "QPlainTextEdit { border: none; }",

  InactiveLabel = Font .. " " .. MainTextColour .. " letter-spacing: 1px; " .. Center,

  FeedbackInactive = FeedbackBorder .. " color: rgb(47,79,79); background-color: rgb(0,0,0);",
  FeedbackActive = FeedbackBorder .. " color: rgb(255,215,0); background-color: rgb(0,83,160);",
}

function ThresholdUI:AdjustFontMetrics()
  local FontName = self.Styles.FontName
  local tallest = 0
  local widest = 0

  -- First, collect all FontSize keys
  local fontSizeKeys = {}
  for key, value in pairs(self.metrics) do
    if string.match(key, "FontSize$") then
      table.insert(fontSizeKeys, key)
    end
  end

  -- Now process them
  for _, key in ipairs(fontSizeKeys) do
    local value = self.metrics[key]
    local width, height = calcFontSize(value, FontName)
    local dimKey = string.gsub(key, "FontSize$", "Dim")

    self.metrics[dimKey] = {
      width = width + (self.metrics.fontPaddingX * 2),
      height = height + (self.metrics.fontPaddingY * 2)
    }

    widest = self.metrics[dimKey].width > widest and self.metrics[dimKey].width or widest
    tallest = self.metrics[dimKey].height > tallest and self.metrics[dimKey].height or tallest
  end

  self.metrics.maxDim = {
    width = widest,
    height = tallest,
  }
end

-- Measures a font size the way AdjustFontMetrics does
function ThresholdUI:MeasureFont(size)
  local width, height = calcFontSize(size, self.Styles.FontName)

  return {
    width = width + (self.metrics.fontPaddingX * 2),
    height = height + (self.metrics.fontPaddingY * 2),
  }
end

-- Works out every size in the UI from the font size preference: the font
-- sizes themselves, then what they measure, then the boxes that have to hold
-- them. Used when the UI is built and when /tui size changes it.
function ThresholdUI:ComputeMetrics()
  local m = self.metrics
  local base = self.BaseFontSizes
  local scale = (self.Prefs.FontSize or self.PrefsDefaults.FontSize) / base.gaugeFontSize

  for key, size in pairs(base) do
    m[key] = math.max(1, math.floor(size * scale + 0.5))
  end

  self:AdjustFontMetrics()

  -- Three rows of gauges, each as tall as the tallest text in the UI
  m.height = m.maxDim.height * 3

  -- Scale the fixed sizes by how the font actually measures, not by the
  -- point size, since fonts don't grow exactly in proportion
  local gaugeBase = self:MeasureFont(base.gaugeFontSize)
  local inactiveBase = self:MeasureFont(base.inactiveFontSize)

  m.vitalsWidth = math.ceil(self.BaseSizes.vitalsWidth * m.gaugeDim.width / gaugeBase.width)
  m.inactiveHeight = math.ceil(self.BaseSizes.inactiveHeight * m.inactiveDim.height / inactiveBase.height)

  -- Meters are one devotion-character wide each; the clock is as wide as the
  -- longest devotion name
  m.metersWidth = 4 * m.devotionDim.width
  m.dateTimeWidth = m.devotionDim.width * ThreshTime.config.longestDevotion
end
