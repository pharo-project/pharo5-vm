primitives
primitiveGetIntProperty
	"Primitive. Returns an integer property for the session"

	| propID handle value |
	<export: true>
	interpreterProxy methodArgumentCount = 2
		ifFalse:[^interpreterProxy primitiveFail].
	propID := interpreterProxy stackIntegerValue: 0.
	handle := interpreterProxy stackIntegerValue: 1.
	interpreterProxy failed ifTrue:[^nil].
	value := self cCode: 'sqGetIntPropertySSL(handle, propID)' 
					inSmalltalk:[handle. propID. 0].
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy 
		pop: interpreterProxy methodArgumentCount + 1
		thenPush: (interpreterProxy signed32BitIntegerFor: value)
