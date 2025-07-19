-- Styles2.lua

-- Centralized color and font definitions
local Colors = {
  mainBg = "rgba(224, 173, 45, 10%)",
  mainBorder = "rgba(224, 173, 45, 10%)",
  gaugeBorder = "rgba(224, 173, 45, 22%)",
  meterBorder = "rgba(20, 20, 20, 100%)",
  mainText = "rgba(200,200,200,90%)",
  dateText = "rgba(224, 173, 45, 100%)",
  feedbackInactive = "rgb(47,79,79)",
  feedbackActive = "rgb(255,215,0)",
  feedbackBgInactive = "rgb(0,0,0)",
  feedbackBgActive = "rgb(0,83,160)",
  transparent = "rgba(0,0,0,0%)",
}

local Fonts = {
  main = "Ubuntu",
  boldWeight = "500",
}

-- Helper to serialize style tables
local function style(tbl)
  local parts = {}
  for k, v in pairs(tbl) do
    table.insert(parts, k .. ": " .. v .. ";")
  end
  return table.concat(parts, " ")
end

-- Declarative style definitions
ThresholdUI.Styles = {
  FontName = Fonts.main,
  MainContainer = style{
    ["background-color"] = Colors.mainBg,
    ["border-top"] = "1px solid " .. Colors.mainBorder,
    ["border-bottom"] = "1px solid " .. Colors.mainBorder,
  },
  GaugeLabel = style{
    ["background-color"] = Colors.transparent,
    ["padding-left"] = "4px",
    ["padding-right"] = "4px",
    ["qproperty-alignment"] = "AlignLeft | AlignVCenter",
    ["font-family"] = Fonts.main,
    ["color"] = Colors.mainText,
  },
  GaugeLabelCombat = style{
    ["background-color"] = Colors.transparent,
    ["padding-left"] = "4px",
    ["padding-right"] = "4px",
    ["qproperty-alignment"] = "AlignLeft | AlignVCenter",
    ["font-family"] = Fonts.main,
    ["color"] = Colors.mainText,
    ["font-weight"] = Fonts.boldWeight,
  },
  GaugeText = style{
    ["color"] = Colors.mainText,
    ["font-family"] = Fonts.main,
    ["qproperty-alignment"] = "AlignCenter | AlignVCenter",
    ["font-weight"] = Fonts.boldWeight,
  },
  HPFrontNormal = style{
    ["background-color"] = "rgb(164, 25, 25)",
    ["border-radius"] = "3px",
    ["border"] = "1px solid " .. Colors.gaugeBorder,
    ["margin"] = "2px 3px",
  },
  -- ...repeat for other gauges, meters, labels, etc...

  MeterFront = style{
    ["background"] = "QLinearGradient( x1: 0, y1: 0, x2: 1, y2: 1, stop: 0 #ffddc9, stop: 0.1 #9e6e3a, stop: 0.95 #6a4825, stop: 1 #ffddc9)",
    ["border-radius"] = "3px",
    ["border"] = "1px solid " .. Colors.meterBorder,
  },
  MeterBack = style{
    ["background"] = "rgba(224, 173, 45, 15%)",
    ["border-radius"] = "3px",
    ["border"] = "1px solid " .. Colors.meterBorder,
  },
  MeterLabel = style{
    ["background-color"] = Colors.transparent,
    ["color"] = Colors.dateText,
    ["qproperty-alignment"] = "AlignCenter | AlignVCenter",
  },
  DateTimeLabel = style{
    ["font-family"] = Fonts.main,
    ["color"] = Colors.dateText,
    ["background-color"] = Colors.transparent,
    ["letter-spacing"] = "1px",
    ["qproperty-alignment"] = "AlignCenter | AlignVCenter",
  },
  InactiveLabel = style{
    ["font-family"] = Fonts.main,
    ["color"] = Colors.mainText,
    ["letter-spacing"] = "1px",
    ["qproperty-alignment"] = "AlignCenter | AlignVCenter",
  },
  FeedbackInactive = style{
    ["border-radius"] = "3px",
    ["border"] = "1px solid " .. Colors.meterBorder,
    ["color"] = Colors.feedbackInactive,
    ["background-color"] = Colors.feedbackBgInactive,
  },
  FeedbackActive = style{
    ["border-radius"] = "3px",
    ["border"] = "1px solid " .. Colors.meterBorder,
    ["color"] = Colors.feedbackActive,
    ["background-color"] = Colors.feedbackBgActive,
  },
  FeedbackFont = Fonts.main,
}

-- You can add more styles as needed, following this pattern.
