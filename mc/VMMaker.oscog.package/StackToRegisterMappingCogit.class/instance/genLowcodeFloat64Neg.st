inline primitive generators generated code
genLowcodeFloat64Neg
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |

	(value := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (value := DPFPReg0)].

	(result := backEnd availableFloatRegisterOrNoneFor: (self liveFloatRegisters bitOr: (self registerMaskFor: value))) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (result := DPFPReg1)].
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self XorRd: result Rd: result.
	self SubRd: value Rd: result.
	self ssPushNativeRegisterDoubleFloat: result.

	^ 0

