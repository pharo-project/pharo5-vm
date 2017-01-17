primitives
primitiveSetIntProperty
	"Primitive. Sets a integer property for the session"

	| propID handle result value |
	<export: true>
	interpreterProxy methodArgumentCount = 3
		ifFalse:[^interpreterProxy primitiveFail].
	value := interpreterProxy signed32BitValueOf: (interpreterProxy stackValue: 0).
	propID := interpreterProxy stackIntegerValue: 1.
	handle := interpreterProxy stackIntegerValue: 2.
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode: 'sqSetIntPropertySSL(handle, propID, value)' 
					inSmalltalk:[handle. propID. value. false].
	result ifFalse:[^interpreterProxy primitiveFail].
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy pop: interpreterProxy methodArgumentCount.
