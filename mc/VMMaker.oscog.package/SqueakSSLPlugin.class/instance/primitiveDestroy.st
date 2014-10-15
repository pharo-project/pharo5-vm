primitives
primitiveDestroy
	"Primitive. Destroys an SSL session."

	| handle result |
	<export: true>
	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFail].
	handle := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	result := self cCode: 'sqDestroySSL(handle)' inSmalltalk:[handle. 0].
	result = 0 ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy pop: interpreterProxy methodArgumentCount.

