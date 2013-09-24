internal interpreter access
stackObjectValue: offset
	"Ensures that the given object is a real object, not a SmallInteger."
	"In the StackInterpreter stacks grow down."
	| oop |
	oop := stackPages longAt: stackPointer + (offset * BytesPerWord).
	(objectMemory isImmediate: oop) ifTrue:
		[self primitiveFail. ^ nil].
	^oop