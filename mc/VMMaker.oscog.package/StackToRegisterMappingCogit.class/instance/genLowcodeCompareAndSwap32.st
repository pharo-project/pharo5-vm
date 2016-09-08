inline primitive generators generated code
genLowcodeCompareAndSwap32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| newValue check oldValue value |

	(newValue := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(newValue := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(oldValue := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: newValue))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (oldValue := Arg1Reg)].

	(check := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: newValue)) bitOr: (self registerMaskFor: oldValue))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (check := SendNumArgsReg)].

	(value := backEnd availableRegisterOrNoneFor: (((self liveRegisters bitOr: (self registerMaskFor: newValue)) bitOr: (self registerMaskFor: oldValue)) bitOr: (self registerMaskFor: check))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (value := ClassReg)].
	(((newValue = ReceiverResultReg or: [oldValue = ReceiverResultReg]) or: [check = ReceiverResultReg]) or: [value = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: newValue.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: oldValue.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: check.
	self ssNativePop: 1.

	self abort.

	^ 0

