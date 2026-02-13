local FontName = "Ubuntu"
local DateTimeFontName = FontName
local Font = f [[ font-family: '{FontName}'; ]]
local DateTimeFont = f [[ font-family: '{DateTimeFontName}'; ]]
local MainTextFont = f [[ {Font} ]]
local MainTextColour = "color: rgba(200,200,200,90%);"
local Bold = "font-weight: 500;"
local Left = "qproperty-alignment: 'AlignLeft | AlignVCenter';"
local Center = "qproperty-alignment: 'AlignCenter | AlignVCenter';"
local Right = "qproperty-alignment: 'AlignRight | AlignVCenter';"
local MainBackgroundColour = "background-color: rgba(224, 173, 45, 10%);"
local MainBorder = "1px solid rgba(224, 173, 45, 10%)"
local GaugeTextFont = f [[ {Font} {MainTextColour} ]]
local GaugeBorder = "border-radius: 3px; border: 1px solid rgba(224, 173, 45, 22%);"
local GaugeMargin = "margin: 2px 3px;"
local MeterBorder = "border-radius: 3px; border: 1px solid rgba(20, 20, 20, 100%);"
local MeterFontName = FontName
local MeterTextFont = f [[ {Font} {MainTextColour} ]]
local MeterFGColour =
"background: QLinearGradient( x1: 0, y1: 0, x2: 1, y2: 1, stop: 0 #ffddc9, stop: 0.1 #9e6e3a, stop: 0.95 #6a4825, stop: 1 #ffddc9);"
local MeterBGColour = "background: rgba(224, 173, 45, 15%);"
local MeterLabel =
"background-color: rgba(0,0,0,0%); color: rgba(224, 173, 45, 100%); qproperty-alignment: 'AlignCenter | AlignVCenter';"
local FeedbackBorder = "border-radius: 3px; border: 1px solid rgba(20, 20, 20, 100%);"
local Transparent = "background-color: rgba(0,0,0,0%);"

ThresholdUI.Styles = ThresholdUI.Styles or {
  FontName = FontName,
  MainContainer = f [[ {MainBackgroundColour} border-top: {MainBorder}; border-bottom: {MainBorder}; ]],

  GaugeLabel = f [[ {Transparent} padding-left: 4px; padding-right: 4px; {Left} {MainTextFont} {MainTextColour} ]],
  GaugeLabelCombat = f [[ {Transparent} padding-left: 4px; padding-right: 4px; {Left} {MainTextFont} {MainTextColour} {Bold} ]],
  GaugeText = f [[ {MainTextColour} {GaugeTextFont} {Center} {Bold} ]],

  HPFrontNormal = f [[ background-color: rgb(164, 25, 25); {GaugeBorder} {GaugeMargin} ]],
  HPFrontStunned = f [[ background-color: rgba(165,0,0, 35%); {GaugeBorder} {GaugeMargin} ]],
  HPBack = f [[ background-color: rgb(32, 5, 5); {GaugeBorder} {GaugeMargin} ]],

  SPFrontNormal = f [[ background-color: rgb(0, 64, 128); {GaugeBorder} {GaugeMargin} ]],
  SPFrontStunned = f [[ background-color: rgba(0, 51, 103, 35%); {GaugeBorder} {GaugeMargin} ]],
  SPBack = f [[ background-color: rgb(44, 48, 50); {GaugeBorder} {GaugeMargin} ]],

  EPFrontNormal = f [[ background-color: rgb(0, 128, 128); {GaugeBorder} {GaugeMargin} ]],
  EPFrontStunned = f [[ background-color: rgba(0, 102, 102, 35%); {GaugeBorder} {GaugeMargin} ]],
  EPBack = f [[ background-color: rgb(0, 51, 51); {GaugeBorder} {GaugeMargin} ]],

  FoeFrontNormal = f [[ background-color: rgb(129,83,0); {GaugeBorder} {GaugeMargin} ]],
  FoeFrontCombat = f [[ background-color: rgb(129,83,0); {GaugeBorder} {GaugeMargin} {Font} {MainTextColour} {Center} {Bold} ]],
  FoeLabelCombat = f [[ {MainTextColour} {Font} {MainTextColour} {Right} {Transparent} padding-right: 4px; {Bold} ]],
  FoeBack = f [[ background-color: rgb(54, 44, 27); {GaugeBorder} {GaugeMargin} ]],
  FoeFoeLabelStyle = f [[ {MainTextColour} {Font} {MainTextColour} {Right} {Transparent} padding-right: 4px; {Bold} ]],

  XPFrontNormal = f [[ background-color: rgb(122, 0, 122); {GaugeBorder} {GaugeMargin} ]],
  XPFrontStunned = f [[ background-color: rgba(153, 0, 153,35%); {GaugeBorder} {GaugeMargin} ]],
  XPBack = f [[ background-color: rgb(52, 0, 52); {GaugeBorder} {GaugeMargin} ]],

  ShieldFrontNormal = f [[ background-color: rgb(34, 90, 34); {GaugeBorder} {GaugeMargin} ]],
  ShieldFrontStunned = f [[ background-color: rgba(34, 90, 34, 35%); {GaugeBorder} {GaugeMargin} ]],
  ShieldBack = f [[ background-color: rgb(0, 26, 0); {GaugeBorder} {GaugeMargin} ]],

  MeterFront = f [[ {MeterFGColour} {MeterBorder} ]],
  MeterBack = f [[ {MeterBGColour} {MeterBorder} ]],
  MeterLabel = f [[ {MeterLabel} ]],
  MeterFontName = MeterFontName,
  MeterTextFont = MeterTextFont,

  DateTimeLabel = f [[ {DateTimeFont} color: rgba(224, 173, 45, 100%); {Transparent} letter-spacing: 1px; {Center} ]],

  InactiveLabel = f [[ {Font} {MainTextColour} letter-spacing: 1px; {Center} ]],

  FeedbackInactive = f [[ {FeedbackBorder} color: rgb(47,79,79); background-color: rgb(0,0,0); ]],
  FeedbackActive = f [[ {FeedbackBorder} color: rgb(255,215,0); background-color: rgb(0,83,160); ]],
}
