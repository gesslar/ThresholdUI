function ThresholdUI:Install(event, package, file)
    if package ~= self.AppName then return end
    deleteNamedEventHandler(self.AppName, self.AppName..".Install")

    self:ConnectionScript()
    cecho("Thank you for installing ThresholdUI!\nInitializing GMCP in Threshold.\n")

    tempTimer(1, function() send("gmcp reset", false) end)
end
registerNamedEventHandler(ThresholdUI.AppName, ThresholdUI.AppName..".Install", "sysInstall", function(event, package, file) ThresholdUI:Install(event, package, file) end)

function ThresholdUI:Uninstall(event, package)
    if package ~= self.AppName then return end
    deleteNamedEventHandler(self.AppName, self.AppName..".Uninstall")
    setBorderTop(0)
    setBorderBottom(0)
    setBorderLeft(0)
    setBorderRight(0)
    setBorderColor(0,0,0)
    setBgColor(0,0,0)
    setBackgroundColor(0,0,0)
    self.MainContainer:hide()
    self:stopTime()
    deleteAllNamedTimers(self.AppName)
    deleteAllNamedEventHandlers(self.AppName)
    ThresholdUI = {}
    cecho("\n<red>You have uninstalled ThresholdUI.\n")
end
registerNamedEventHandler(ThresholdUI.AppName, ThresholdUI.AppName..".Uninstall", "sysUninstall", function(event, package) ThresholdUI:Uninstall(event, package) end)
