initialize-release
initialiseModule

	self class isInitialised ifFalse: [| ivars |
		ivars := #(opTable maskTable warpBitShiftTable ditherMatrix4x4 ditherThresholds16 ditherValues16 dither8Lookup).
		super initialiseModule.
		ivars do: [:symbol | self class instVarNamed: symbol put: (self instVarNamed: symbol)].
		self class setInitialised].
	opTable := self class opTable.
	maskTable := self class maskTable.
	warpBitShiftTable := self class warpBitShiftTable.
	ditherMatrix4x4 := self class ditherMatrix4x4.
	ditherThresholds16 := self class ditherThresholds16.
	ditherValues16 := self class ditherValues16.
	dither8Lookup := self class dither8Lookup.
	^true