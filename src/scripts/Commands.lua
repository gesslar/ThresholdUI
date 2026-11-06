-- /tui <command> [<args>], dispatched from the single /tui alias

ThresholdUI.Commands = {
  datetime = {
    help = "<h2>/tui datetime</h2> [on|off] - Show or hide the game clock. Toggles with no argument.",
    run = function(self, arg)
      if arg == nil then
        arg = self.Prefs.TimeBox == false and "on" or "off"
      end

      self:ToggleTimeBox(nil, arg)
    end,
  },
  regen = {
    help = "<h2>/tui regen</h2> [on|off] - Show or hide the regen tick meter. Toggles with no argument.",
    run = function(self, arg)
      if arg == nil then
        arg = self.Prefs.HealTick == false and "on" or "off"
      end

      self:ToggleHealTick(nil, arg)
    end,
  },
  size = {
    help = "<h2>/tui size</h2> [<6-40>|default] - Set the font size; the bar resizes to fit. Shows the current size with no argument.",
    run = function(self, arg) self:SetSize(arg) end,
  },
}

ThresholdUI.CommandOrder = { "datetime", "regen", "size" }

ThresholdUI.HelpStyles = {
  h1 = "goldenrod",
  h2 = "dark_goldenrod",
}

-- Prints the /tui help, through Helper when it's installed and as plain text
-- when it isn't (yet)
function ThresholdUI:ShowHelp()
  local lines = {
    "<h1>__PKGNAME__ __VERSION__</h1>",
    "",
    "  <h2>/tui</h2> - See this help.",
  }

  for _, key in ipairs(self.CommandOrder) do
    table.insert(lines, "  " .. self.Commands[key].help)
  end

  local text = table.concat(lines, "\n") .. "\n"

  echo("\n")
  ---@diagnostic disable-next-line: undefined-global
  if helper and helper.print then
    ---@diagnostic disable-next-line: undefined-global
    helper.print({ text = text, styles = self.HelpStyles })
  else
    echo((string.gsub(text, "</?%w+>", "")))
  end
end

function ThresholdUI:Command(_, input)
  local name, arg = string.match(input or "", "^%s*(%S*)%s*(%S*)")
  local command = self.Commands[string.lower(name or "")]

  if command == nil then
    self:ShowHelp()
    return
  end

  if arg == "" then
    arg = nil
  else
    arg = string.lower(arg)
  end

  command.run(self, arg)
end
