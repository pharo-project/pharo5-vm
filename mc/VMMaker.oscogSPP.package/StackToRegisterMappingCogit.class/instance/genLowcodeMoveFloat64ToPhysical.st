inline primitive generators generated code
genLowcodeMoveFloat64ToPhysical
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| registerID value |
	registerID := extA.

	(value := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (value := DPFPReg0)].
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self abort.

	extA := 0.
	^ 0

