I/O primitives
primitiveEventProcessingControl
	"With 0 args answers whether ioProcessEvents is enabled and being called.
	 With 1 arg expects a boolean which will enable ioProcessEvents if true and
	 disable it if false, answering its previous state."
	<export: true>
	| enabled |
	enabled := inIOProcessEvents >= 0.
	argumentCount = 0 ifTrue:
		[^self pop: 1 thenPushBool: enabled].
	argumentCount = 1 ifTrue:
		[self stackTop = objectMemory trueObject
			ifTrue: [inIOProcessEvents < 0 ifTrue:
					[inIOProcessEvents := 0]]
			ifFalse:
				[self stackTop = objectMemory falseObject
					ifTrue: [inIOProcessEvents := -1]
					ifFalse: [self primitiveFailFor: PrimErrBadArgument.
							^self]].
		 ^self pop: 2 thenPushBool: enabled].
	self primitiveFailFor: PrimErrBadNumArgs