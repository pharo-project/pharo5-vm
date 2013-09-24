method prototypes
BehaviorPROTOTYPEhandleFailingFailingBasicNew
	"This basicNew gets sent after failingBasicNew: has sent Smalltalk garbageCollect.
	 If this fails then the system really is low on space.

	 Primitive. Answer an instance of this class with the number of indexable
	 variables specified by the argument, sizeRequested.  Fail if this class is not
	 indexable or if the argument is not a positive Integer, or if there is not
	 enough memory available. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 70>
	self isVariable ifTrue: [^self basicNew: 0].
	"space must be low"
	OutOfMemory signal.
	^self basicNew  "retry if user proceeds"