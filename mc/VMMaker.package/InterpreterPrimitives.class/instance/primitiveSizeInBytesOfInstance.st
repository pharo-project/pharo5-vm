memory space primitives
primitiveSizeInBytesOfInstance
	"Answer the byte size of an instance of the receiver.  If num args > 0
	 then the last argument is a variable size and the size answered is the
	 size of an instance of the receiver with that many indexable elements."
	<option: #SpurObjectMemory>
	| byteSizeOrErr |
	self cppIf: NewspeakVM
		ifTrue: "Support VMMirror>>byteSizeOfInstanceOf:WithIndexableVariables:"
			[argumentCount > 2 ifTrue:
				[^self primitiveFailFor: PrimErrBadNumArgs]]
		ifFalse:
			[argumentCount > 1 ifTrue:
				[^self primitiveFailFor: PrimErrBadNumArgs]].
	argumentCount >= 1 ifTrue:
		[(objectMemory isIntegerObject: self stackTop) ifFalse:
			[^self primitiveFailFor: PrimErrBadArgument].
		 byteSizeOrErr := objectMemory
								byteSizeOfInstanceOf: (self stackValue: 1)
								withIndexableSlots: (objectMemory integerValueOf: self stackTop).
		 byteSizeOrErr < 0 ifTrue:
			[^self primitiveFailFor: byteSizeOrErr negated].
		 ^self pop: argumentCount + 1 thenPushInteger: byteSizeOrErr].
	byteSizeOrErr := objectMemory byteSizeOfInstanceOf: (self stackValue: 0).
	byteSizeOrErr < 0 ifTrue:
		[^self primitiveFailFor: byteSizeOrErr negated].
	self pop: 1 thenPushInteger: byteSizeOrErr