-- Inset 2px all round. Geyser places children by geometry, not CSS, so a
-- padding in MainContainer's stylesheet wouldn't move them.
ThresholdUI.BarBox = ThresholdUI.BarBox or Geyser.HBox:new({
  name = "BarBox",
  x = 2, y = 2,
  width = "100%-4", height = "100%-4"
}, ThresholdUI.MainContainer)
