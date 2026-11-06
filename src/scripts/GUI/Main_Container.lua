-- Work out how big everything is from the font size preference
ThresholdUI:ComputeMetrics()

-- Now that we know our height, BAM! SET THE THINGS!
setBorderBottom(ThresholdUI.metrics.height)

-- Drop the input line's frame so it sits flush under the bar
setCmdLineStyleSheet("main", ThresholdUI.Styles.CommandLine)

ThresholdUI.MainContainer = ThresholdUI.MainContainer or Geyser.Label:new({
  name = "MainContainer",
  x = 2, y = -(ThresholdUI.metrics.height-2),
  width = "100%", height = (ThresholdUI.metrics.height-2),
  stylesheet = ThresholdUI.Styles.MainContainer
})
