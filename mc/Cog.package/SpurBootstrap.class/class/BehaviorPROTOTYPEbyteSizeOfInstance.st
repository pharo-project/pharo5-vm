method prototypes
BehaviorPROTOTYPEbyteSizeOfInstance
	"Answer the total memory size of an instance of the receiver."

	<primitive: 181>
	self isVariable ifTrue:
		[^self byteSizeOfInstanceOfSize: 0].
	self primitiveFailed