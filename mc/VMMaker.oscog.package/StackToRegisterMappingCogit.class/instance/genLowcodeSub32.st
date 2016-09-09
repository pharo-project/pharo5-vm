inline primitive generators generated code
genLowcodeSub32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second first |

	(second := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(second := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(first := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: second))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (first := Arg1Reg)].
	(second = ReceiverResultReg or: [first = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: second.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: first.
	self ssNativePop: 1.

	self SubR: second R: first.
	self ssPushNativeRegister: first.

	^ 0

