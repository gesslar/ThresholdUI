-- Main table
ThresholdUI = ThresholdUI or {}

-- Threshold App Name
ThresholdUI.AppName = ThresholdUI.AppName or "ThresholdUI"

-- Threshold App Directory
ThresholdUI.AppDir = f"{getMudletHomeDir()}/{ThresholdUI.appName}"

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
    height = 76,
    inactiveHeight = 20,
    gauge_label_font_size = 12,
    gauge_font_size = 13
}

-- Bar updater
function ThresholdUI:SetBarValue(bar, curr, max, text)
    local curr_value

    if curr < 0 then curr_value = 0
    else curr_value = curr
    end

    if text ~= nil then bar:setValue(curr_value, max, f"<center>{text}</center>")
    else bar:setValue(curr_value, max, f"<center>{curr}/{max}</center>")
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
