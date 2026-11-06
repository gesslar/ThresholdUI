ThresholdUI.SysHandlers = ThresholdUI.SysHandlers or {
  { "sysInstall",   "ThresholdUI:Install" },
  { "sysUninstall", "ThresholdUI:Uninstall" },
  { "sysLoadEvent", "ThresholdUI:SysLoadEvent" },
}

function ThresholdUI:Install(event, pkg)
  if pkg ~= self.AppName then return end

  deleteNamedEventHandler(self.AppName, self.AppName .. ".sysInstall")

  self:ConnectionScript()
  -- Fresh install: show the /tui help once Helper is there to format it
  self:LoadDependencies(true)
  cecho("<goldenrod>[__PKGNAME__]<r> Welcome to __PKGNAME__ __VERSION__.\n")

  tempTimer(1, 'send("gmcp reset", false)')
end

function ThresholdUI:Uninstall(event, pkg)
  if pkg ~= self.AppName then return end

  -- The bottom border is the only one this package sets
  setBorderBottom(0)
  setCmdLineStyleSheet("main", "")
  self.MainContainer:hide()
  self.FeedbackBox:hide()
  -- Top-level like FeedbackBox, so hiding MainContainer doesn't cover it
  self.InactiveContainer:hide()
  deleteAllNamedTimers(self.AppName)
  deleteAllNamedEventHandlers(self.AppName)
  -- Drop the cached module so an upgrade loads the newly vendored Glu rather
  -- than the copy already in memory. (The handler's argument is named `pkg`
  -- so it doesn't shadow Lua's `package` library.)
  package.loaded[self.AppName .. "/vendor/Glu-single"] = nil
  ThresholdUI = {}
  cecho("<goldenrod>[__PKGNAME__]<r> You have uninstalled __PKGNAME__ __VERSION__.\n")
end

-- Installs anything in ThresholdUI.Dependencies that isn't installed yet, then
-- shows the /tui help if `announce` is set (on a fresh install)
function ThresholdUI:LoadDependencies(announce)
  local deps = self.glu.dependency_queue(self.Dependencies, function(ok, message)
    if not ok then
      cecho("<tomato>[__PKGNAME__]<r> " .. (message or "Couldn't install dependencies.") .. "\n")
    end

    if announce then
      -- Runs straight away when Helper is already installed; the timer puts
      -- the help after the welcome line either way
      tempTimer(0.1, function() self:ShowHelp() end)
    end
  end)

  -- nil when everything is already installed
  if deps then deps.start() end
end

function ThresholdUI:SysLoadEvent(_, notProfileReset)
  if not notProfileReset then
    self:ConnectionScript()
    self:LoadDependencies()

    tempTimer(0.5, 'send("gmcp reset", false)')
  end
end

for _, v in ipairs(ThresholdUI.SysHandlers) do
  local event, handler = v[1], v[2]

  registerNamedEventHandler(ThresholdUI.AppName, ThresholdUI.AppName .. "." .. event, event, handler)
end
