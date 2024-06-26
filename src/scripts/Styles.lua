local GaugeBorder = "border-radius: 3px; border: 1px solid rgba(224, 173, 45, 22%);"
local GaugeMargin = "margin: 2px 3px;"
local MeterBorder = "border-radius: 3px; border: 1px solid rgba(20, 20, 20, 100%);"
local MeterFGColor = "background: QLinearGradient( x1: 0, y1: 0, x2: 1, y2: 1, stop: 0 #ffddc9, stop: 0.1 #9e6e3a, stop: 0.95 #6a4825, stop: 1 #ffddc9);"
local MeterBGColor = "background: rgba(107, 22, 1, 15%);"
local MeterLabel = "background-color: rgba(0,0,0,0%); font-weight: bolder; color: rgba(224, 173, 45, 100%); qproperty-alignment: AlignBottom;"
local GaugeFont = "font-family: 'Bitstream Vera Serif', serif;"
local GaugeLabelFont = "font-family: 'Bitstream Vera Serif', serif;"
local FeedbackBorder = "border-radius: 3px; border: 1px solid rgba(20, 20, 20, 100%);"
-- local FeedbackFont = "font-family: 'Bitstream Vera Serif', serif;"

ThresholdUI.Styles = ThresholdUI.Styles or {
  MainContainer = [[ background-color: rgb(20, 20, 20); ]],
  GaugeText = f[[ padding-top: 2px; color: rgb(211,211,211); {GaugeFont} qproperty-alignment: 'AlignRight|AlignVCenter'; ]],
  
  HPFrontNormal = f[[ background: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(164, 25, 25), stop: 0.1 rgb(190,0,0), stop: 0.85 rgb(165,0,0), stop: 1 rgb(139,0,0)); {GaugeBorder} {GaugeMargin} ]],
  HPFrontStunned = f[[ background-color: rgba(165,0,0, 35%); {GaugeBorder} {GaugeMargin} ]],
  HPBack = f[[ background-color: rgb(32, 5, 5); {GaugeBorder} {GaugeMargin} ]],

  SPFrontNormal = f[[ background: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(0, 64, 128), stop: 0.1 rgb(0, 77, 154), stop: 0.85 rgb(0, 51, 103), stop: 1 rgb(0, 64, 128)); {GaugeBorder} {GaugeMargin} ]],
  SPFrontStunned = f[[ background-color: rgba(0, 51, 103, 35%); {GaugeBorder} {GaugeMargin} ]],
  SPBack = f[[ background-color: rgb(44, 48, 50); {GaugeBorder} {GaugeMargin} ]],

  EPFrontNormal = f[[ background: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(125,66,66), stop: 0.1 rgb(154,0,76), stop: 0.85 rgb(129,0,64), stop: 1 rgb(125,66,66)); {GaugeBorder} {GaugeMargin} ]],
  EPFrontStunned = f[[ background-color: rgba(129,0,64, 35%); {GaugeBorder} {GaugeMargin} ]],
  EPBack = f[[ background-color: rgb(51, 40, 40); {GaugeBorder} {GaugeMargin} ]],

  FoeFrontNormal = f[[ background: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(129,83,0), stop: 0.1 rgb(180, 115, 0), stop: 0.85 rgb(154,99,0), stop: 1 rgb(129,83,0)); {GaugeBorder} {GaugeMargin}  ]],
  FoeFrontStunned = f[[ background-color: rgba(154,99,0,35%); {GaugeBorder} {GaugeMargin} ]],
  FoeBack = f[[ background-color: rgb(54, 44, 27); {GaugeBorder} {GaugeMargin} ]],

  XPFrontNormal = f[[ background: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(77,0,77), stop: 0.1 rgb(154,0,154), stop: 0.85 rgb(128,0,128), stop: 1 rgb(77,0,77)); {GaugeBorder} {GaugeMargin} ]],
  XPFrontStunned = f[[ background-color: rgba(128,0,128,35%); {GaugeBorder} {GaugeMargin} ]],
  XPBack = f[[ background-color: rgb(52, 0, 52); {GaugeBorder} {GaugeMargin} ]],

  ShieldFrontNormal = f[[ background: QLinearGradient( x1: 0, y1: 0, x2: 0, y2: 1, stop: 0 rgb(0,26,0), stop: 0.1 rgb(0,103,0), stop: 0.85 rgb(0,77,0), stop: 1 rgb(0,26,0)); {GaugeBorder} {GaugeMargin} ]],
  ShieldFrontStunned = f[[ background-color: rgba(0, 77, 0, 35%); {GaugeBorder} {GaugeMargin} ]],
  ShieldBack = f[[ background-color: rgb(0, 26, 0); {GaugeBorder} {GaugeMargin} ]],

  CapacityFront = f[[ {MeterFGColor} {MeterBorder} ]],
  CapacityBack = f[[ {MeterBGColor} {MeterBorder} ]],
  CapacityText = f[[ {MeterLabel} ]],
  
  TummyFront = f[[ {MeterFGColor} {MeterBorder} ]],
  TummyBack = f[[ {MeterBGColor} {MeterBorder} ]],
  TummyText = f[[ {MeterLabel} ]],
  
  HealBankFront = f[[ {MeterFGColor} {MeterBorder} ]],
  HealBankBack = f[[ {MeterBGColor} {MeterBorder} ]],
  HealBankText = f[[ {MeterLabel} ]],
  
  HealTickFront = f[[ {MeterFGColor} {MeterBorder} ]],
  HealTickBack = f[[ {MeterBGColor} {MeterBorder} ]],
  HealTickText = f[[ {MeterLabel} ]],
  
  BreathFront = f[[ {MeterFGColor} {MeterBorder} ]],
  BreathBack = f[[ {MeterBGColor} {MeterBorder} ]],
  BreathText = f[[ {MeterLabel} ]],
  
  RestLabel = [[ background-color: rgba(30,30,30,100%) ; ]],
  DateTimeLabel = [[ color: rgba(224, 173, 45, 100%); background-color: rbga(0,0,0,0%); ]],
  InnerLabelStyle = f[[ font-weight: 100; padding-left: 5px; background-color: rgba(0,0,0,0%); {GaugeLabelFont} ]],
  
  FoeFoeLabelStyle = f[[ font-weight: 100; padding-left: 5px; background-color: rgba(0,0,0,0%); {GaugeLabelFont} qproperty-alignment: 'AlignRight | AlignVCenter'; ]],
  
  FeedbackInactive = f[[ {FeedbackBorder} color: rgb(47,79,79); background-color: rgb(0,0,0); ]],
  FeedbackActive = f[[ {FeedbackBorder} color: rgb(255,215,0); background-color: rgb(0,83,160); ]],
}

ThresholdUI.Assets = {
  BG = f"{ThresholdUI.AssetsPath}/New_BG.jpg"
}

setBorderBottom(ThresholdUI.metrics.height)
setBorderColor(22,19,15)
-- setBgColor(0,0,0,0)
-- setBackgroundColor(22,19,15,0)
-- setBackgroundImage(f[[background-image: url({ThresholdUI.Assets.BG}); background-repeat: no-repeat; background-position: top; background-size: cover;]], "style")