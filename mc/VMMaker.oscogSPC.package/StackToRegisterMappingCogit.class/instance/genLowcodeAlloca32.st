inline primitive generators generated code
genLowcodeAlloca32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| size |

	(size := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(size := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	size = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: size.
	self ssNativePop: 1.

	self MoveAw: coInterpreter nativeStackPointerAddress R: TempReg.
	self SubR: size R: TempReg.
	self AndCq: -16 R: TempReg.
	self MoveR: TempReg R: size.
	self MoveR: size Aw: coInterpreter nativeStackPointerAddress.
	self ssPushNativeRegister: size.

	^ 0

