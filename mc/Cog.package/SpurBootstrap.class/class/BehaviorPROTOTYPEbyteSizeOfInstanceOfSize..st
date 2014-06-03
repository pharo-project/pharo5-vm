method prototypes
BehaviorPROTOTYPEbyteSizeOfInstanceOfSize: basicSize
	"Answer the total memory size of an instance of the receiver
	 with the given number of indexable instance variables."

	<primitive: 181>
	self isVariable ifFalse:
		[basicSize = 0 ifTrue:
			[^self byteSizeOfInstance]].
	self primitiveFailed