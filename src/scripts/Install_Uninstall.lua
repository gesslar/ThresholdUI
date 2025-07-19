ThresholdUI.SysHandlers = ThresholdUI.SysHandlers or {
  {"sysInstall", f[[ThresholdUI:Install]]},
  {"sysUninstall", f[[ThresholdUI:Uninstall]]},
}

function ThresholdUI:Install(event, package)
  if package ~= self.AppName then return end

  deleteNamedEventHandler(self.AppName, self.AppName..".sysInstall")

  self:ConnectionScript()
  cecho("<red>Thank you for installing ThresholdUI!\n")
  echo("\n")
  cecho("<blue>Initializing GMCP in Threshold.\n")

  tempTimer(1, f[[send("gmcp reset", false)]])
end

function ThresholdUI:Uninstall(event, package)
    if package ~= self.AppName then return end

  setBorderTop(0)
  setBorderBottom(0)
  setBorderLeft(0)
  setBorderRight(0)
  setBorderColor(0,0,0)
  setBgColor(0,0,0)
  setBackgroundColor(0,0,0)
  self.MainContainer:hide()
  self.FeedbackBox:hide()
  deleteAllNamedTimers(self.AppName)
  deleteAllNamedEventHandlers(self.AppName)
  ThresholdUI = {}
  cecho("<red>You have uninstalled ThresholdUI.\n")
end

for _, v in ipairs(ThresholdUI.SysHandlers) do
  local event, handler = v[1], v[2]

  registerNamedEventHandler(ThresholdUI.AppName, ThresholdUI.AppName.."."..event, event, handler)
end
