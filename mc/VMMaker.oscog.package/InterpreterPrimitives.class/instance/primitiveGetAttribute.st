system control primitives
primitiveGetAttribute
	"Fetch the system attribute with the given integer ID. The 
	result is a string, which will be empty if the attribute is not 
	defined."
	| attr sz s |
	attr := self stackIntegerValue: 0.
	self successful
		ifTrue: [sz := self attributeSize: attr].
	self successful
		ifTrue: [s := objectMemory
						instantiateClass: (objectMemory splObj: ClassByteString)
						indexableSize: sz.
			self
				getAttribute: attr
				Into: s + objectMemory baseHeaderSize
				Length: sz.
			self pop: 2 thenPush: s]