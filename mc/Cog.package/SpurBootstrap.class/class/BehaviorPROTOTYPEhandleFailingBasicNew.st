method prototypes
BehaviorPROTOTYPEhandleFailingBasicNew
	"This basicNew gets sent after basicNew has failed and allowed a
	 scavenging garbage collection to occur.  The scavenging collection
	 will have happened as the VM is activating the (failing) basicNew.
	 If failingBasicNew fails then the scavenge failed to reclaim sufficient
	 space and a global garbage collection is required.

	 Primitive. Answer an instance of this class with the number of indexable
	 variables specified by the argument, sizeRequested.  Fail if this class is not
	 indexable or if the argument is not a positive Integer, or if there is not
	 enough memory available. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 70>
	self isVariable ifTrue: [^self basicNew: 0].
	Smalltalk garbageCollect.
	^self failingFailingBasicNew "retry after global garbage collect"