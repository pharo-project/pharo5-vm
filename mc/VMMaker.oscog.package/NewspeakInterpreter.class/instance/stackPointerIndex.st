internal interpreter access
stackPointerIndex
	"Return the 0-based index rel to the current context.
	(This is what stackPointer used to be before conversion to pointer"
	<inline: true>
	^self stackPointerIndexFor: stackPointer context: activeContext