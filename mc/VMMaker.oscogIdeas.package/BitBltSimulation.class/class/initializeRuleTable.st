initialization
initializeRuleTable
	"BitBltSimulation initializeRuleTable"
	"**WARNING** You MUST change initBBOpTable if you change this"
	OpTable := #(
		"0" clearWord:with:
		"1" bitAnd:with:
		"2" bitAndInvert:with:
		"3" sourceWord:with:
		"4" bitInvertAnd:with:
		"5" destinationWord:with:
		"6" bitXor:with:
		"7" bitOr:with:
		"8" bitInvertAndInvert:with:
		"9" bitInvertXor:with:
		"10" bitInvertDestination:with:
		"11" bitOrInvert:with:
		"12" bitInvertSource:with:
		"13" bitInvertOr:with:
		"14" bitInvertOrInvert:with:
		"15" destinationWord:with:
		"16" destinationWord:with: "unused - was old paint"
		"17" destinationWord:with: "unused - was old mask"
		"18" addWord:with:
		"19" subWord:with:
		"20" rgbAdd:with:
		"21" rgbSub:with:
		"22" OLDrgbDiff:with:
		"23" OLDtallyIntoMap:with:
		"24" alphaBlend:with:
		"25" pixPaint:with:
		"26" pixMask:with:
		"27" rgbMax:with:
		"28" rgbMin:with:
		"29" rgbMinInvert:with:
		"30" alphaBlendConst:with:
		"31" alphaPaintConst:with:
		"32" rgbDiff:with:
		"33" tallyIntoMap:with:
		"34" alphaBlendScaled:with:

		"35" alphaBlendScaled:with:	"unused here - only used by FXBlt"
		"36" alphaBlendScaled:with:	"unused here - only used by FXBlt"
		"37" rgbMul:with:
		"38" pixSwap:with:
		"39" pixClear:with:
		"40" fixAlpha:with:
		"41" rgbComponentAlpha:with:
	).
	OpTableSize := OpTable size + 1.  "0-origin indexing"
