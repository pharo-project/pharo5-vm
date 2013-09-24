debug support
firstFixedFieldOfMaybeImmediate: oop
	"for the message send breakpoint; selectors can be immediates."
	<inline: false>
	^(self isImmediate: oop)
		ifTrue: [oop]
		ifFalse: [self firstFixedField: oop]