contexts
fetchStackPointerOf: aContext
	"Return the stackPointer of a Context or BlockContext."
	| sp |
	<inline: true>
	sp := self fetchPointer: StackPointerIndex ofObject: aContext.
	(self isIntegerObject: sp) ifFalse: [^0].
	self assert: ReceiverIndex + (self integerValueOf: sp) < (self lengthOf: aContext).
	^self integerValueOf: sp