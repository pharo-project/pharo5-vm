inline primitive generators generated code
genLowcodeBoolean32ToOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value inst cont object trueJump |

	(value := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(value := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].

	(object := backEnd availableRegisterOrNoneFor: (self liveRegisters bitOr: (self registerMaskFor: value))) = NoReg ifTrue:
		[self ssAllocateRequiredReg: (object := Arg1Reg)].
	(value = ReceiverResultReg or: [object = ReceiverResultReg]) ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self CmpCq: 0 R: value.
	trueJump := self JumpNonZero: 0.
	"False"
	self annotate: (self MoveCw: objectMemory falseObject R: value) objRef: objectMemory falseObject.
	cont := self Jump: 0.
	"True"
	inst := self MoveCw: objectMemory trueObject R: value.
	trueJump jmpTarget: inst.
	self annotate: inst objRef: objectMemory trueObject.
	cont jmpTarget: self Label.
	self ssPushRegister: value.

	^ 0

