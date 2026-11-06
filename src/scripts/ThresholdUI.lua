-- Main table
ThresholdUI = ThresholdUI or {}

-- Threshold App Name
ThresholdUI.AppName = ThresholdUI.AppName or "ThresholdUI"

-- Glu
ThresholdUI.glu = ThresholdUI.glu or
    require(ThresholdUI.AppName .. "/vendor/Glu-single")(ThresholdUI.AppName)

local glu = ThresholdUI.glu

-- Prefs (stored in the profile directory so they survive reinstalls)
ThresholdUI.PrefsFile = ThresholdUI.AppName .. ".Preferences.lua"
ThresholdUI.PrefsDefaults = {
  HealTick = true,
  TimeBox = true,
  FontSize = 13, -- the gauge text size; /tui size <n>
}
ThresholdUI.Prefs = ThresholdUI.Prefs or {}

-- Packages installed alongside this one. Helper formats the /tui help; the UI
-- itself doesn't need it, so it's never waited on.
ThresholdUI.Dependencies = {
  { name = "Helper", url = "https://github.com/gesslar/Helper/releases/latest/download/Helper.mpackage" },
}

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

-- Every font size at the default size. /tui size sets the gauge text size and
-- the rest keep these proportions to it (see ThresholdUI:ComputeMetrics).
ThresholdUI.BaseFontSizes = {
  gaugeLabelFontSize = 12,
  gaugeFontSize = 13,
  inactiveFontSize = 11,
  meterFontSize = 8,
  dateFontSize = 11,
  dayFontSize = 11,
  hourFontSize = 11,
  devotionFontSize = 11,
}

-- Fixed sizes laid out for the default fonts; they're scaled by how much
-- bigger the relevant font actually measures
ThresholdUI.BaseSizes = {
  vitalsWidth = 280,     -- against the gauge text
  inactiveHeight = 20,   -- against the resting text
}

-- Filled in by ThresholdUI:ComputeMetrics
ThresholdUI.metrics = {
  fontPaddingX = 2,
  fontPaddingY = 2,
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

  if bar_value > bar_max then
    -- The gauges aren't strict, so anything over 100% spills past the frame
    bar_value = bar_max
  end
  if text ~= nil then
    bar:setValue(bar_value, bar_max, text)
  else
    bar:setValue(bar_value, bar_max, curr .. "/" .. tostring(max))
  end
end

-- Reads a numeric field from gmcp.Char.Status. Returns nil when the field is
-- missing or isn't a number, so handlers can bail out instead of erroring.
function ThresholdUI:StatusNumber(key)
  local status = gmcp.Char and gmcp.Char.Status

  return status and tonumber(status[key]) or nil
end

function ThresholdUI:LoadPrefs()
  self.Prefs = glu.preferences.load(nil, self.PrefsFile, self.PrefsDefaults)
end

function ThresholdUI:SavePrefs()
  glu.preferences.save(nil, self.PrefsFile, self.Prefs)
end
