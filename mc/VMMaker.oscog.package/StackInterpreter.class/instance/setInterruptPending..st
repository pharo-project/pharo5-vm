plugin primitive support
setInterruptPending: value
	self forceInterruptCheck.
	interruptPending := value