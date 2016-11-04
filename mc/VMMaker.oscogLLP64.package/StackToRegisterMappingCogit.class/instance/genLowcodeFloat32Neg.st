inline primitive generators generated code
genLowcodeFloat32Neg
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |

	(value := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (value := DPFPReg0)].

	(result := backEnd availableFloatRegisterOrNoneFor: (self liveFloatRegisters bitOr: (self registerMaskFor: value))) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (result := DPFPReg1)].
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self XorRs: result Rs: result.
	self SubRs: value Rs: result.
	self ssPushNativeRegisterSingleFloat: result.

	^ 0

