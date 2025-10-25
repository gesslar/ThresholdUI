-- Adjust the dimensions based on the font and font sizes used in the UI
ThresholdUI:AdjustFontMetrics()

-- Set the new height
ThresholdUI.metrics.height = ThresholdUI.metrics.maxDim.height * 3

-- Now that we know our height, BAM! SET THE THINGS!
setBorderBottom(ThresholdUI.metrics.height)

ThresholdUI.MainContainer = ThresholdUI.MainContainer or Geyser.Label:new({
  name = "MainContainer",
  x = 2, y = -(ThresholdUI.metrics.height-2),
  width = "100%", height = (ThresholdUI.metrics.height-2),
  stylesheet = ThresholdUI.Styles.MainContainer
})
