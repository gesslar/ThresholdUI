-- Now that we know our height, BAM! SET THE THINGS!
setBorderBottom(ThresholdUI.metrics.height)

ThresholdUI.MainContainer = ThresholdUI.MainContainer or Geyser.Label:new({
  name = "MainContainer",
  x = 2,
  y = -(ThresholdUI.metrics.height),
  width = "100%",
  height = (ThresholdUI.metrics.height),
  stylesheet = ThresholdUI.Styles.MainContainer
})
