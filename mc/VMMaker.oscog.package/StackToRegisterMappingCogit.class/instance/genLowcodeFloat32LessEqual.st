inline primitive generators generated code
genLowcodeFloat32LessEqual
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value contJump falseJump first second |

	(second := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (second := DPFPReg0)].

	(first := backEnd availableFloatRegisterOrNoneFor: (self liveFloatRegisters bitOr: (self registerMaskFor: second))) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (first := DPFPReg1)].

	(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(value := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	value = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: second.
	self ssNativePop: 1.
	self ssNativeTop nativePopToReg: first.
	self ssNativePop: 1.

	self CmpRs: second Rs: first.
	falseJump := self JumpFPGreater: 0.
	"True result"
	self MoveCq: 1 R: value.
	contJump := self Jump: 0.
	"False result"
	falseJump jmpTarget: self Label.
	self MoveCq: 0 R: value.
	contJump jmpTarget: self Label.
	self ssPushNativeRegister: value.

	^ 0

