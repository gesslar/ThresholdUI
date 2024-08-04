ThresholdUI.Feedback = ThresholdUI.Feedback or {}
ThresholdUI.FeedbackLabels = {"shock", "net", "mastery", "gaze"}
ThresholdUI.FeedbackBox =
    ThresholdUI.FeedbackBox or
    Geyser.HBox:new({
        name = "FeedbackContainer",
        x = 0,
        y = -(ThresholdUI.metrics.height + ThresholdUI.metrics.inactiveHeight),
        height = ThresholdUI.metrics.inactiveHeight,
        width = "100%",
    })

-- Create the labels for each feedback ability
for _, v in ipairs(ThresholdUI.FeedbackLabels) do
    local label = "Feedback_" .. Capitalize(v)
    ThresholdUI[label] = ThresholdUI[label] or Geyser.Label:new({
        name = label,
        message = f([[<center>{v}</center>]])
    }, ThresholdUI.FeedbackBox)
    ThresholdUI[label]:echo(nil, "nocolor", "bc")
    ThresholdUI[label]:setStyleSheet(ThresholdUI.Styles.FeedbackInactive)
end
ThresholdUI.FeedbackBox:hide()

function ThresholdUI:FeedbackToggle()
    -- Inactive bar is not being shown
    if not resumeNamedTimer(self.AppName, self.AppName .. ".InactiveTimer") then
        -- We have no feedback: hide
        if not gmcp.Char.Feedback or not #gmcp.Char.Feedback then
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

function ThresholdUI:UpdateFeedback()
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
