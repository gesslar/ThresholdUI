local glu = ThresholdUI.glu

ThresholdUI.Feedback = ThresholdUI.Feedback or {}
ThresholdUI.FeedbackLabels = {"shock", "net", "mastery", "gaze"}
ThresholdUI.FeedbackBox = ThresholdUI.FeedbackBox or Geyser.HBox:new({
  name = "FeedbackContainer",
  x = 0, y = -(ThresholdUI.metrics.height + ThresholdUI.metrics.inactiveHeight)+2,
  height = ThresholdUI.metrics.inactiveHeight, width = "100%",
})

-- Create the labels for each feedback ability
for _, v in ipairs(ThresholdUI.FeedbackLabels) do
  local label = "Feedback_" .. glu.string.capitalize(v)
  ThresholdUI[label] = ThresholdUI[label] or Geyser.Label:new({
    name = label,
    message = f([[<center>{v}</center>]])
  }, ThresholdUI.FeedbackBox)

  ThresholdUI[label]:echo(nil, "nocolor", "bc")
  ThresholdUI[label]:setStyleSheet(ThresholdUI.Styles.FeedbackInactive)
end

-- Hide the feedback bar initially until detected that is needed.
ThresholdUI.FeedbackBox:hide()

function ThresholdUI:FeedbackToggle()
  -- Inactive bar is not being shown
  if self.InactiveContainer.hidden then
    -- We have no feedback (not a psion): hide
    if not gmcp.Char or not gmcp.Char.Feedback then
      self.FeedbackBox:hide()
      setBorderBottom(self.metrics.height)
      -- We have feedback: show
    else
      self.FeedbackBox:show()
      setBorderBottom(self.metrics.height + self.metrics.inactiveHeight)
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
    local label = "Feedback_" .. glu.string.capitalize(v)

    if glu.table.includes(gmcp.Char.Feedback, v) then
      self[label]:setStyleSheet(self.Styles.FeedbackActive)
    else
      self[label]:setStyleSheet(self.Styles.FeedbackInactive)
    end
  end
end
