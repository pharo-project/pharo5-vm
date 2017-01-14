inline primitive generators generated code
genLowcodeStoreLocalFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	baseOffset := extA.

	(value := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (value := DPFPReg0)].
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self loadNativeLocalAddress: baseOffset to: TempReg.
	self MoveRs: value M32: 0 r: TempReg.

	extA := 0.
	^ 0

