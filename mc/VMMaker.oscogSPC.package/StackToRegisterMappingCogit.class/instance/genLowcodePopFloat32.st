inline primitive generators generated code
genLowcodePopFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value |

	(value := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (value := DPFPReg0)].
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.


	^ 0

