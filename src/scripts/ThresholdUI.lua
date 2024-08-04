-- Main table
ThresholdUI = ThresholdUI or {}

-- Threshold App Name
ThresholdUI.AppName = ThresholdUI.AppName or "ThresholdUI"

-- Threshold App Directory
ThresholdUI.AppDir = f"{getMudletHomeDir()}/{ThresholdUI.AppName}"

-- Prefs
ThresholdUI.PrefsFile = f"{ThresholdUI.AppDir}/prefs.lua"
ThresholdUI.Prefs = ThresholdUI.Prefs or {}

-- Assets directory
ThresholdUI.AssetsPath = f"{ThresholdUI.AppDir}/assets"

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
    gauge_label_font_size = 12,
    gauge_font_size = 13,
    inactive_font_size = 11
}

local function round(num)
    if num >= 0 then
        return math.floor(num + 0.5)
    else
        return math.ceil(num - 0.5)
    end
end


-- Bar updater
function ThresholdUI:SetBarValue(bar, curr, max, text)
    local curr_value
    local bar_value, bar_max

    if curr < 0 then curr_value = 0
    else curr_value = curr
    end

    bar_value = round(curr_value * 100 / max)
    bar_max = 100

    if bar_value < 5 then
        bar_value = 0
    end
    if text ~= nil then bar:setValue(bar_value, bar_max, f"{text}")
    else bar:setValue(bar_value, bar_max, f"{curr}/{max}")
    end
end

function ThresholdUI:LoadPrefs()
    if io.open(self.PrefsFile) ~= nil then
        table.load(self.PrefsFile, self.Prefs)
    end
end

function ThresholdUI:SavePrefs()
    table.save(self.PrefsFile, self.Prefs)
end

function Capitalize(str)
    return (str:gsub("^%l", string.upper))
end
