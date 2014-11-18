utilities
sizeOfSTArrayFromCPrimitive: cPtr
	"Return the number of indexable fields of the given object. This method is to be called from an automatically generated C primitive. The argument is assumed to be a pointer to the first indexable field of a words or bytes object; the object header starts 4 bytes before that."
	"Note: Only called by translated primitive code."

	| oop |
	<var: #cPtr type: 'void *'>
	oop := (self oopForPointer: cPtr) - objectMemory baseHeaderSize.
	(objectMemory isWordsOrBytes: oop) ifFalse: [
		self primitiveFail.
		^0].
	^objectMemory lengthOf: oop
