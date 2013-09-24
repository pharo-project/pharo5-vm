method prototypes
BehaviorPROTOTYPEhandleFailingFailingBasicNew: sizeRequested
	"This basicNew: gets sent after failingBasicNew: has sent Smalltalk garbageCollect.
	 If that fails the system really is low on space.

	 Primitive. Answer an instance of this class with the number of indexable
	 variables specified by the argument, sizeRequested.  Fail if this class is not
	 indexable or if the argument is not a positive Integer, or if there is not
	 enough memory available. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 71>
	self isVariable ifFalse:
		[self error: self printString, ' cannot have variable sized instances'].
	(sizeRequested isInteger and: [sizeRequested >= 0]) ifTrue:
		["arg okay; space must be low."
		OutOfMemory signal.
		^self basicNew: sizeRequested  "retry if user proceeds"].
	self primitiveFailed