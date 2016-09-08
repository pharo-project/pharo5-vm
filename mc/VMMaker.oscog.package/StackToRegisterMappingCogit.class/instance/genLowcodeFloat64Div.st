inline primitive generators generated code
genLowcodeFloat64Div
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second first |

	(second := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (second := DPFPReg0)].

	(first := backEnd availableFloatRegisterOrNoneFor: (self liveFloatRegisters bitOr: (self registerMaskFor: second))) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (first := DPFPReg1)].
	self ssNativeTop nativePopToReg: second.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: first.
	self ssNativePop: 1.

	self DivRd: second Rd: first.
	self ssPushNativeRegisterDoubleFloat: first.

	^ 0

