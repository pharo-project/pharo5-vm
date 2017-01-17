inline primitive generators generated code
genLowcodeFloat64ToUInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| floatValue int64Result |

	(floatValue := backEnd availableFloatRegisterOrNoneFor: self liveFloatRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredFloatReg: (floatValue := DPFPReg0)].

	(int64Result := backEnd availableRegisterOrNoneFor: self liveRegisters) = NoReg ifTrue:
		[self ssAllocateRequiredReg:
			(int64Result := optStatus isReceiverResultRegLive
				ifTrue: [Arg0Reg]
				ifFalse: [ReceiverResultReg])].
	int64Result = ReceiverResultReg ifTrue:
		[ optStatus isReceiverResultRegLive: false ].
	self ssNativeTop nativePopToReg: floatValue.
	self ssNativePop: 1.

	self ConvertRd: floatValue R: int64Result.
	self ssPushNativeRegister: int64Result.

	^ 0

