trampolines
returnRegForStoreCheck
	"We must ensure the ReceiverResultReg is live across the store check so that
	 we can store into receiver inst vars in a frameless method since self exists
	 only in ReceiverResultReg in a frameless method.  So if ReceiverResultReg is
	 caller-saved we use the fact that ceStoreCheck: answers its argument to
	 reload ReceiverResultReg cheaply.  Otherwise we don't care about the result
	 and use the cResultRegister, effectively a no-op (see compileTrampoline...)"
	<inline: true>
	^(self isCallerSavedReg: ReceiverResultReg)
		ifTrue: [ReceiverResultReg]
		ifFalse: [backEnd cResultRegister]