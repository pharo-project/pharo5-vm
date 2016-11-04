inline primitive generators generated code
genLowcodeDuplicateFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value dup2 |

	(value := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (value := DPFPReg0)].

	(dup2 := backEnd availableFloatRegisterOrNoneFor: (self liveFloatRegisters bitOr: (self registerMaskFor: value))) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (dup2 := DPFPReg1)].
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self MoveRs: value Rs: dup2.
	self ssPushNativeRegisterSingleFloat: value;
	ssPushNativeRegisterSingleFloat: dup2.

	^ 0

