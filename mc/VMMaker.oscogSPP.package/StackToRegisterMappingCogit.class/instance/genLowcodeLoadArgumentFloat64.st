inline primitive generators generated code
genLowcodeLoadArgumentFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| baseOffset doubleValue |
	baseOffset := extA.

	(doubleValue := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (doubleValue := DPFPReg0)].

	self loadNativeArgumentAddress: baseOffset to: TempReg.
	self MoveM64: 0 r: TempReg Rd: doubleValue.
	self ssPushNativeRegisterDoubleFloat: doubleValue.

	extA := 0.
	^ 0

