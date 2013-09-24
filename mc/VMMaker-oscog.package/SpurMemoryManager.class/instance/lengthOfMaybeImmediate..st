debug support
lengthOfMaybeImmediate: oop
	"for the message send breakpoint; selectors can be immediates."
	<inline: false>
	(self isImmediate: oop) ifTrue: [^0].
	^self lengthOf: oop