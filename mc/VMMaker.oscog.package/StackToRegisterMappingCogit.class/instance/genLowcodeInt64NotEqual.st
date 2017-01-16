inline primitive generators generated code
genLowcodeInt64NotEqual
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| falseLabel first contJump falseJump secondLow secondHigh second falseJump2 firstHigh firstLow |
	BytesPerWord = 4 ifTrue: [

		(secondLow := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
			[self ssAllocateRequiredReg:
				(secondLow := optStatus isReceiverResultRegLive
					ifTrue: [Arg0Reg]
					ifFalse: [ReceiverResultReg])].

		(secondHigh := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: secondLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (secondHigh := Arg1Reg)].

		(firstLow := backEnd availableRegisterOrNoneFor: ((self liveRegisters bitOr: (self registerMaskFor: secondLow)) bitOr: (self registerMaskFor: secondHigh))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (firstLow := SendNumArgsReg)].

		(firstHigh := backEnd availableRegisterOrNoneFor: (((self liveRegisters bitOr: (self registerMaskFor: secondLow)) bitOr: (self registerMaskFor: secondHigh)) bitOr: (self registerMaskFor: firstLow))) = NoReg ifTrue:
			[self ssAllocateRequiredReg: (firstHigh := ClassReg)].
		(((secondLow = ReceiverResultReg or: [secondHigh = ReceiverResultReg]) or: [firstLow = ReceiverResultReg]) or: [firstHigh = ReceiverResultReg]) ifTrue:
			[ optStatus isReceiverResultRegLive: false ].
		self ssNativeTop nativePopToReg: secondLow secondReg: secondHigh.
		self ssNativePop: 1.
		self ssNativeTop nativePopToReg: firstLow secondReg: firstHigh.
		self ssNativePop: 1.

		self CmpR: secondHigh R: firstHigh.
		falseJump := self JumpNonZero: 0.
		self CmpR: secondLow R: firstLow.
		falseJump2 := self JumpNonZero: 0.
		"False result"
		self MoveCq: 0 R: firstLow.
		contJump := self Jump: 0.
		"True result"
		falseLabel := self MoveCq: 1 R: firstLow.
		falseJump jmpTarget: falseLabel.
		falseJump2 jmpTarget: falseLabel.
		contJump jmpTarget: self Label.
		self ssPushNativeRegister: firstLow.

	] ifFalse: [

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

		self CmpR: second R: first.
		falseJump := self JumpZero: 0.
		"True result"
		self MoveCq: 1 R: first.
		contJump := self Jump: 0.
		"False result"
		falseJump jmpTarget: self Label.
		self MoveCq: 0 R: first.
		contJump jmpTarget: self Label.
		self ssPushNativeRegister: first.

	].
	^ 0

