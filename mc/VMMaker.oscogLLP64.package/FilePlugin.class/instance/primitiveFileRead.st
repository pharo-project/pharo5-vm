file primitives
primitiveFileRead
	<export: true>
	self cppIf: SPURVM
		ifTrue: [self primitiveFileReadWithPinning]
		ifFalse: [self primitiveFileReadWithoutPinning]