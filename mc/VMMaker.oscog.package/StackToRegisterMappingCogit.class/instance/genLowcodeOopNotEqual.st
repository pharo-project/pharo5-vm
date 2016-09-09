inline primitive generators generated code
genLowcodeOopNotEqual
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second falseJump contJump first |

	(second := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(second := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(first := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: second))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (first := Arg1Reg)].
	(second = ReceiverResultReg or: [first = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssTop popToReg: second.
	self ssPop: 1.
	self ssTop popToReg: first.
	self ssPop: 1.

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

	^ 0

