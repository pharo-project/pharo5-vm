testing
testIsValidVersionNumber

	self should: [ImageFormat fromInteger: 0] raise: Error.
	self should: [ImageFormat fromInteger: (6502 bitAnd: 16r80000000)] raise: Error.
	self should: [ImageFormat fromInteger: (6502 bitAt: 31 put: 1)] raise: Error.
	self should: [ImageFormat fromInteger: 6500] raise: Error.
	self should: [ImageFormat fromInteger: 6501] raise: Error.
	self should: [ImageFormat fromInteger: 6503] raise: Error. "Cog requires both capabilities"
	self should: [ImageFormat fromInteger: 68001] raise: Error. "Cog requires both capabilities"

	self assert: ImageFormat default isValidVersionNumber.
	self assert: (ImageFormat wordSize: 4 closures: false) isValidVersionNumber.
	self assert: (ImageFormat wordSize: 4 closures: true) isValidVersionNumber.
	self assert: (ImageFormat wordSize: 8 closures: false) isValidVersionNumber.
	self assert: (ImageFormat wordSize: 8 closures: true) isValidVersionNumber.
	self assert: (ImageFormat fromInteger: 6502) isValidVersionNumber.
	self assert: (ImageFormat fromInteger: (6502 bitAt: 31 put: 0)) isValidVersionNumber.
	self assert: (ImageFormat fromInteger: 6521) isValidVersionNumber.
	self assert: (ImageFormat fromInteger: 68019) isValidVersionNumber.

