process primitive support
adjustInterruptCheckCounterFeedback
	"Answer true if we should adjust the interrupt counter feedback.
	Only do this if the current interrupt wasn't forced and we're not
	profiling execution"
	^self interruptCheckForced = false and:[nextProfileTick = 0].