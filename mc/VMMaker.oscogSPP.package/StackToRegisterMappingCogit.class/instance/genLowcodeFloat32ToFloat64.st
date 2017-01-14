inline primitive generators generated code
genLowcodeFloat32ToFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| singleFloatValue |

	(singleFloatValue := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (singleFloatValue := DPFPReg0)].
	self ssNativeTop nativePopToReg: singleFloatValue.
	self ssNativePop: 1.

	self ConvertRs: singleFloatValue Rd: singleFloatValue.
	self ssPushNativeRegisterDoubleFloat: singleFloatValue.

	^ 0

