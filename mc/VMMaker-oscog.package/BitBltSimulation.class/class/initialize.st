initialization
initialize
	"BitBltSimulation initialize"

	self initializeRuleTable.

	"Mask constants"
	AllOnes := 16rFFFFFFFF.
	BinaryPoint := 14.
	FixedPt1 := 1 << BinaryPoint.  "Value of 1.0 in Warp's fixed-point representation"
 
	"Indices into stopConditions for scanning"
	EndOfRun := 257.
	CrossedX := 258.
 
	"Form fields"
	FormBitsIndex := 0.
	FormWidthIndex := 1.
	FormHeightIndex := 2.
	FormDepthIndex := 3.
 
	"BitBlt fields"
	BBDestFormIndex := 0.
	BBSourceFormIndex := 1.
	BBHalftoneFormIndex := 2.
	BBRuleIndex := 3.
	BBDestXIndex := 4.
	BBDestYIndex := 5.
	BBWidthIndex := 6.
	BBHeightIndex := 7.
	BBSourceXIndex := 8.
	BBSourceYIndex := 9.
	BBClipXIndex := 10.
	BBClipYIndex := 11.
	BBClipWidthIndex := 12.
	BBClipHeightIndex := 13.
	BBColorMapIndex := 14.
	BBWarpBase := 15.
	BBLastIndex := 15.
	BBXTableIndex := 16.

	"RGBA indexes"
	RedIndex := 0.
	GreenIndex := 1.
	BlueIndex := 2.
	AlphaIndex := 3.

	"Color map flags"
	ColorMapPresent := 1.		"do we have one?"
	ColorMapFixedPart := 2.		"does it have a fixed part?"
	ColorMapIndexedPart := 4.	"does it have an indexed part?"
	ColorMapNewStyle := 8.		"new style color map"