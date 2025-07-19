-- Adjust the dimensions based on the font and font sizes used in the UI
ThresholdUI:AdjustFontMetrics()

-- Determine heights
local mainHeight = ThresholdUI.metrics.maxDim.height * 3
local inactiveHeight = ThresholdUI.metrics.inactiveDim.height + 4
local totalHeight = mainHeight + inactiveHeight

-- Record the new heights
ThresholdUI.metrics.height = mainHeight
ThresholdUI.metrics.inactiveHeight = inactiveHeight
ThresholdUI.metrics.totalHeight = totalHeight

-- Now that we know our height, BAM! SET THE THINGS!
setBorderBottom(ThresholdUI.metrics.height)
