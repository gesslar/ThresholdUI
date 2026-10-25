-- Main table
ThresholdUI = ThresholdUI or {}

-- Threshold App Name
ThresholdUI.AppName = ThresholdUI.AppName or "ThresholdUI"

-- Threshold App Directory
ThresholdUI.AppDir = f "{getMudletHomeDir()}/{ThresholdUI.AppName}"

-- Glu
ThresholdUI.glu = ThresholdUI.glu or
    require(ThresholdUI.AppName .. "/vendor/Glu-single")(ThresholdUI.AppName)

local glu = ThresholdUI.glu

-- Prefs (stored in the profile directory so they survive reinstalls)
ThresholdUI.PrefsFile = f "{ThresholdUI.AppName}.Preferences.lua"
ThresholdUI.PrefsDefaults = {
  HealTick = true,
  TimeBox = true,
}
ThresholdUI.Prefs = ThresholdUI.Prefs or {}

-- Assets directory
ThresholdUI.AssetsPath = f "{ThresholdUI.AppDir}/assets"

-- Enable these GMCP modules
ThresholdUI.enableModules = { "Char", "Core", "External" }

-- Disable these GMCP modules
ThresholdUI.disableModules = { "\"IRE.Composer\"", "\"IRE.Rift\"", "\"IRE.Client.Media\"" }

-- Global Vitals
ThresholdUI.Vitals = ThresholdUI.Vitals or {
  hp = 0,
  maxhp = 0,
  sp = 0,
  maxsp = 0,
  ep = 0,
  maxep = 0,
}

ThresholdUI.metrics = {
  height = 80,
  inactiveHeight = 20,
  fontPaddingX = 2,
  fontPaddingY = 2,
  gaugeLabelFontSize = 12,
  gaugeFontSize = 13,
  inactiveFontSize = 11,
  meterFontSize = 8,
  dateFontSize = 12,
  dayFontSize = 11,
  hourFontSize = 11,
  devotionFontSize = 12,
}

-- Bar updater
function ThresholdUI:SetBarValue(bar, curr, max, text)
  local curr_value
  local bar_value, bar_max

  if curr < 0 then
    curr_value = 0
  else
    curr_value = curr
  end

  if max == nil or max <= 0 then
    bar_value = 0
  else
    bar_value = glu.number.round(curr_value * 100 / max)
  end
  bar_max = 100

  if bar_value < 5 then
    bar_value = 0
  end
  if text ~= nil then
    bar:setValue(bar_value, bar_max, f "{text}")
  else
    bar:setValue(bar_value, bar_max, f "{curr}/{max}")
  end
end

function ThresholdUI:LoadPrefs()
  self.Prefs = glu.preferences.load(nil, self.PrefsFile, self.PrefsDefaults)
end

function ThresholdUI:SavePrefs()
  glu.preferences.save(nil, self.PrefsFile, self.Prefs)
end
