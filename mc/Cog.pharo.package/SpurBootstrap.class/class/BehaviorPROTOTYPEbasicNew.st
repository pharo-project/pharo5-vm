method prototypes
BehaviorPROTOTYPEbasicNew
	"Primitive. Answer an instance of the receiver (which is a class) with no 
	 indexable variables. Fail if the class is indexable. Essential. See Object 
	 documentation whatIsAPrimitive.
	
	 If the primitive fails because space is low then the scavenger
	 will run before the method is activated.  Check arguments and
	 retry via handleFailingBasicNew if they're OK."

	<primitive: 70>
	self isVariable ifTrue: [^self basicNew: 0].
	"space must have been low, and the scavenger must have run.
	 retry after the scavenge."
	^self handleFailingBasicNew