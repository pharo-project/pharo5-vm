memory space primitives
primitiveSizeInBytesOfInstance
	"Answer the byte size of an instance of the receiver.  If num args > 0
	 then the last argument is a variable size and the size answered is the
	 size of an instance of the receiver with that many indexable elements."
	<option: #SpurObjectMemory>
	| byteSize err |
	NewspeakVM
		ifTrue: "Support VMMirror>>byteSizeOfInstanceOf:WithIndexableVariables:"
			[argumentCount > 2 ifTrue:
				[^self primitiveFailFor: PrimErrBadNumArgs]]
		ifFalse:
			[argumentCount > 1 ifTrue:
				[^self primitiveFailFor: PrimErrBadNumArgs]].
	err := -1.
	argumentCount >= 1 ifTrue:
		[(objectMemory isIntegerObject: self stackTop) ifFalse:
			[^self primitiveFailFor: PrimErrBadArgument].
		 byteSize := objectMemory
						byteSizeOfInstanceOf: (self stackValue: 1)
						withIndexableSlots: (objectMemory integerValueOf: self stackTop)
						errInto: [:code| err := code].
		 err >= 0 ifTrue:
			[^self primitiveFailFor: err].
		 ^self pop: argumentCount + 1 thenPush: (self positive64BitIntegerFor: byteSize)].
	byteSize := objectMemory
						byteSizeOfInstanceOf: (self stackValue: 0)
						errInto: [:code| err := code].
	err >= 0 ifTrue:
		[^self primitiveFailFor: err].
	self pop: 1 thenPushInteger: byteSize