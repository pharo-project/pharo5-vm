tests
testImmediateFloats
	"self new testImmediateFloats"
	| vm smm smallFloatOop |
	vm := StackInterpreterSimulator newWithOptions: #(ObjectMemory Spur64BitMemoryManager).
	smm := vm objectMemory.
	#(0.0 -0.0 1.0e38 -1.0e38 1.0e-38 -1.0e-38 2.0 -2.0) do:
		[:f| | sfo |
		vm initPrimCall.
		self shouldnt: [sfo := smm smallFloatObjectOf: f] raise: Error.
		self assert: (smm smallFloatValueOf: sfo) equals: f.
		self assert: ((smm exponentOfSmallFloat: sfo) between: -126 and: 127)].
	{Float nan. Float infinity. Float negativeInfinity. 1.0e-39. 1.0e39. 5.8774717541114375e-39. 6.80564733841877e38 } do:
		[:f| self deny: (smm isSmallFloatValue: f)].
	vm initPrimCall.
	smallFloatOop := smm smallFloatTag + (1 << (smm smallFloatMantissaBits + smm numTagBits)).
	self shouldnt: [smm floatValueOf: smallFloatOop] raise: Error.
	self deny: vm failed.
	self assert: (smm isSmallFloatValue: (smm floatValueOf: smallFloatOop)).
	self assert: (smm floatObjectOf: (smm floatValueOf: smallFloatOop)) equals: smallFloatOop.
	vm initPrimCall.
	smallFloatOop := ((1 bitShift: 64) - 1 bitClear: (1 bitShift: smm numTagBits + 1) - 1) + smm smallFloatTag.
	self shouldnt: [smm floatValueOf: smallFloatOop] raise: Error.
	self deny: vm failed.
	self assert: (smm isSmallFloatValue: (smm floatValueOf: smallFloatOop)).
	self assert: (smm floatObjectOf: (smm floatValueOf: smallFloatOop)) equals: smallFloatOop