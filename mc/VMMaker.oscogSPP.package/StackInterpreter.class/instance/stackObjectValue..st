stack access
stackObjectValue: offset
	"Ensures that the given object is a real object, not a SmallInteger."
	"In the StackInterpreter stacks grow down."
	| oop |
	oop := stackPages longAt: stackPointer + (offset * objectMemory wordSize).
	(objectMemory isImmediate: oop) ifTrue:
		[self primitiveFail. ^ nil].
	^oop