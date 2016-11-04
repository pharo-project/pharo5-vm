inline primitive generators generated code
genLowcodeOopToBoolean32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object |

	(object := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(object := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	object = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssTop popToReg: object.
	self ssPop: 1.

	self annotate: (self SubCw: objectMemory falseObject R: object) objRef: objectMemory falseObject.
	self ssPushNativeRegister: object.

	^ 0

