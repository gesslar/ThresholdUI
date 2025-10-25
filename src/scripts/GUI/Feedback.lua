local mainHeight = ThresholdUI.metrics.height
local inactiveHeight = ThresholdUI.metrics.inactiveHeight
local totalHeight = ThresholdUI.metrics.totalHeight
local fontName = ThresholdUI.Styles.FeedbackFont
local fontSize = ThresholdUI.metrics.inactiveFontSize

ThresholdUI.Feedback = ThresholdUI.Feedback or {}
ThresholdUI.FeedbackLabels = {"shock", "net", "mastery", "gaze"}
ThresholdUI.FeedbackBox = ThresholdUI.FeedbackBox or Geyser.HBox:new({
  name = "FeedbackContainer",
  x = 0, y = -totalHeight,
  height = inactiveHeight, width = "100%",
})

-- Create the labels for each feedback ability
for _, v in ipairs(ThresholdUI.FeedbackLabels) do
  local label = "Feedback_" .. Capitalize(v)
  ThresholdUI[label] = ThresholdUI[label] or Geyser.Label:new({
    name = label,
    message = f([[<center>{v}</center>]]),
    font = fontName, fontSize = fontSize,
  }, ThresholdUI.FeedbackBox)

  ThresholdUI[label]:echo(nil, "nocolor", "bc")
  ThresholdUI[label]:setStyleSheet(ThresholdUI.Styles.FeedbackInactive)
end

-- Hide the feedback bar initially until detected that is needed.
ThresholdUI.FeedbackBox:hide()

function ThresholdUI:FeedbackToggle()
  -- Inactive bar is not being shown
  if self.InactiveContainer.hidden then

  if not gmcp.Char or not gmcp.Char.Feedback or not #gmcp.Char.Feedback then
    -- We have no feedback: hide
    self.FeedbackBox:hide()
    setBorderBottom(mainHeight)
  else
    -- We have feedback: show
    self.FeedbackBox:show()

    setBorderBottom(totalHeight)
  end

  -- Inactive bar is being shown
  else
    self.FeedbackBox:hide()
  end
end

ThresholdUI:FeedbackToggle()

function ThresholdUI:UpdateFeedback()
  if self.FeedbackBox.hidden then
    self:FeedbackToggle()
  end

  for _, v in ipairs(self.FeedbackLabels) do
    local label = "Feedback_" .. Capitalize(v)
    local found = false
    for _, feedback in ipairs(gmcp.Char.Feedback) do
      if v == feedback then
        found = true
      end
    end

    if found == true then
      self[label]:setStyleSheet(self.Styles.FeedbackActive)
    else
      self[label]:setStyleSheet(self.Styles.FeedbackInactive)
    end
  end
end
