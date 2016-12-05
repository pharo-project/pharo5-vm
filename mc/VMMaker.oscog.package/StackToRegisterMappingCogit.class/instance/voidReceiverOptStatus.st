bytecode generator support
voidReceiverOptStatus
	"Used to mark ReceiverResultReg as dead or not containing simSelf.
	 Used when the simStack has already been flushed, e.g. for sends."
	<inline: true>
	optStatus isReceiverResultRegLive: false