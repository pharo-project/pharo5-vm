system control primitives
primitiveGetAttribute
	"Fetch the system attribute with the given integer ID. The 
	result is a string, which will be empty if the attribute is not 
	defined."
	| attr sz s |
	attr := self stackIntegerValue: 0.
	successFlag
		ifTrue: [sz := self attributeSize: attr].
	successFlag
		ifTrue: [s := self
						instantiateClass: (self splObj: ClassByteString)
						indexableSize: sz.
			self
				getAttribute: attr
				Into: s + BaseHeaderSize
				Length: sz.
			self pop: 2 thenPush: s]