primitives
primitiveSetStringProperty
	"Primitive. Sets a string property for the session"

	| srcLen srcOop propID handle srcPtr result |
	<var: #srcPtr type: 'char *'>
	<export: true>
	interpreterProxy methodArgumentCount = 3
		ifFalse:[^interpreterProxy primitiveFail].
	srcOop := interpreterProxy stackValue: 0.
	propID := interpreterProxy stackIntegerValue: 1.
	handle := interpreterProxy stackIntegerValue: 2.
	interpreterProxy failed ifTrue:[^nil].
	(interpreterProxy isBytes: srcOop) 
		ifFalse:[^interpreterProxy primitiveFail].
	srcPtr := interpreterProxy firstIndexableField: srcOop.
	srcLen := interpreterProxy byteSizeOf: srcOop.
	result := self cCode: 'sqSetStringPropertySSL(handle, propID, srcPtr, srcLen)' 
					inSmalltalk:[handle. srcPtr. propID. srcLen. false].
	result ifFalse:[^interpreterProxy primitiveFail].
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy pop: interpreterProxy methodArgumentCount.
