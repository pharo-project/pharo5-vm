testing
testAsInteger

	self assert: (ImageFormat fromInteger: 6502) asInteger = 6502.
	self assert: (ImageFormat fromInteger: 6504) asInteger = 6504.
	self assert: (ImageFormat fromInteger: 68000) asInteger = 68000.
	self assert: (ImageFormat fromInteger: 68002) asInteger = 68002.
	self assert: (ImageFormat fromInteger: 6521) asInteger = 6521.
	self assert: (ImageFormat fromInteger: 68019) asInteger = 68019.
	