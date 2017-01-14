inline primitive generators generated code
genLowcodeFloat64ToFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| floatValue |

	(floatValue := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (floatValue := DPFPReg0)].
	self ssNativeTop nativePopToReg: floatValue.
	self ssNativePop: 1.

	self ConvertRd: floatValue Rs: floatValue.
	self ssPushNativeRegisterSingleFloat: floatValue.

	^ 0

