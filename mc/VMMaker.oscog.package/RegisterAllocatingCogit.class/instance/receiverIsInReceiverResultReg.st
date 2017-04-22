bytecode generator support
receiverIsInReceiverResultReg
	"Used to mark ReceiverResultReg as dead or not containing simSelf.
	 Used when the simStack has already been flushed, e.g. for sends."
	<inline: true>
	^simSelf liveRegister = ReceiverResultReg