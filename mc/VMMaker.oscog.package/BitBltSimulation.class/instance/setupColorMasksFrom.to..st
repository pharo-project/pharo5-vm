interpreter interface
setupColorMasksFrom: srcBits to: targetBits
	"Setup color masks for converting an incoming RGB pixel value from srcBits to targetBits."
	| mask shifts masks deltaBits |
	<var: #shifts declareC:'static int shifts[4] = {0, 0, 0, 0}'>
	<var: #masks declareC:'static unsigned int masks[4] = {0, 0, 0, 0}'>
	self cCode:'' inSmalltalk:[
		shifts := CArrayAccessor on: (IntegerArray new: 4).
		masks := CArrayAccessor on: (WordArray new: 4).
	].
	deltaBits := targetBits - srcBits.
	deltaBits = 0 ifTrue:[^0].
	deltaBits <= 0
		ifTrue:[	mask := 1 << targetBits - 1.
				"Mask for extracting a color part of the source"
				masks at: RedIndex put: mask << (srcBits*2 - deltaBits).
				masks at: GreenIndex put: mask << (srcBits - deltaBits).
				masks at: BlueIndex put: mask << (0 - deltaBits).
				masks at: AlphaIndex put: 0]
		ifFalse:[	mask := 1 << srcBits - 1.
				"Mask for extracting a color part of the source"
				masks at: RedIndex put: mask << (srcBits*2).
				masks at: GreenIndex put: mask << srcBits.
				masks at: BlueIndex put: mask].

	"Shifts for adjusting each value in a cm RGB value"
	shifts at: RedIndex put: deltaBits * 3.
	shifts at: GreenIndex put: deltaBits * 2.
	shifts at: BlueIndex put: deltaBits.
	shifts at: AlphaIndex put: 0.

	cmShiftTable := shifts.
	cmMaskTable := masks.
	cmFlags := cmFlags bitOr: (ColorMapPresent bitOr: ColorMapFixedPart).
