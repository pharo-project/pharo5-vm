inline primitive generators generated code
genLowcodeFloat64ToInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| floatValue int32Result |

	(floatValue := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (floatValue := DPFPReg0)].

	(int32Result := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(int32Result := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	int32Result = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: floatValue.
	self ssNativePop: 1.

	self ConvertRd: floatValue R: int32Result.
	self ssPushNativeRegister: int32Result.

	^ 0

