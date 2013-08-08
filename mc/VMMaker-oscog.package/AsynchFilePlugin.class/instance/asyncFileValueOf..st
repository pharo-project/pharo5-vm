primitives
asyncFileValueOf: oop
	"Return a pointer to the first byte of the async file record within the given Smalltalk bytes object, or nil if oop is not an async file record."

	<returnTypeC: 'AsyncFile *'>
	interpreterProxy success:
		((interpreterProxy isIntegerObject: oop) not and:
		 [(interpreterProxy isBytes: oop) and:
		 [(interpreterProxy slotSizeOf: oop) = (self cCode: 'sizeof(AsyncFile)')]]).
	interpreterProxy failed ifTrue: [^ nil].
	^ self cCode: '(AsyncFile *) (oop + 4)'
