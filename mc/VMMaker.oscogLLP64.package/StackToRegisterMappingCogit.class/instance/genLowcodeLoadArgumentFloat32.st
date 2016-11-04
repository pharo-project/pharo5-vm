inline primitive generators generated code
genLowcodeLoadArgumentFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| baseOffset floatValue |
	baseOffset := extA.

	(floatValue := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (floatValue := DPFPReg0)].

	self loadNativeArgumentAddress: baseOffset to: TempReg.
	self MoveM32: 0 r: TempReg Rs: floatValue.
	self ssPushNativeRegisterSingleFloat: floatValue.

	extA := 0.
	^ 0

