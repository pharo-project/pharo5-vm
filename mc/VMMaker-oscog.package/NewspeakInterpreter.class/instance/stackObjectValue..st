internal interpreter access
stackObjectValue: offset
	"Ensures that the given object is a real object, not a SmallInteger."

	| oop |
	oop := self longAt: stackPointer - (offset * BytesPerWord).
	(self isIntegerObject: oop) ifTrue: [self primitiveFail. ^ nil].
	^ oop
