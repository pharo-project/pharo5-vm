contexts
stackObjectValue: offset
	"Ensures that the given object is a real object, not a SmallInteger."

	| oop |
	oop := self longAt: stackPointer - (offset * self wordSize).
	(self isIntegerObject: oop) ifTrue: [self primitiveFail. ^ nil].
	^ oop
