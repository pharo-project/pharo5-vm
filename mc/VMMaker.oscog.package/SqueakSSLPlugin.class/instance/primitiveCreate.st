primitives
primitiveCreate
	"Primitive. Creates a new SSL session and returns its handle."
	| handle |
	<export: true>
	interpreterProxy methodArgumentCount = 0 
		ifFalse:[^interpreterProxy primitiveFail].
	handle := self cCode: 'sqCreateSSL()' inSmalltalk:[0].
	handle = 0 ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy pop: interpreterProxy methodArgumentCount+1.
	interpreterProxy pushInteger: handle.
