ThresholdUI.MainContainer = ThresholdUI.MainContainer or
    Geyser.Container:new({
        name = "MainContainer",
        x = 2,
        y = -(ThresholdUI.metrics.height - 2),
        width = "100%",
        height = ThresholdUI.metrics.height - 2,
    })

ThresholdUI.Background = ThresholdUI.Background or
    Geyser.Label:new({
        name = "ThresholdUI.Background",
        x = 0, y = 0, width = "100%", height = "100%"
    }, ThresholdUI.MainContainer)

-- ThresholdUI.Background:setStyleSheet([[
-- background-image: url(]]..ThresholdUI.Assets.BG..[[) ;
-- background-size: 'cover' ;
-- ]])
