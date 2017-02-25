process primitive support
waitingPriorityIsAtLeast: minPriority
	"Set the maxWaitingPriority to at least minPriority on behalf
	 of a thread wanting to acquire the VM.  If maxWaitingPriority
	 is increased, schedule a thread activation check asap."
	maxWaitingPriority < minPriority ifTrue:
		[maxWaitingPriority := minPriority.
		 checkThreadActivation := true.
		 self forceInterruptCheck]