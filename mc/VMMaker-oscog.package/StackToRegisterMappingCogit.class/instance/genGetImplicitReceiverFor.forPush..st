bytecode generators
genGetImplicitReceiverFor: selector forPush: forPushSendBar
	"Cached implicit receiver implementation.  Caller looks like
		mov selector, ClassReg
				call cePushImplicitReceiver
				br continue
		Lclass	.word
		Lmixin:	.word
		continue:
	 If class matches class of receiver then mixin contains either 0 or the implicit receiver.
	 If 0, answer the actual receiver.  This is done in the trampoline.
	 See generateNewspeakRuntime."
	self ssAllocateCallReg: SendNumArgsReg and: ReceiverResultReg and: ClassReg and: Arg1Reg.
	^super genGetImplicitReceiverFor: selector forPush: forPushSendBar