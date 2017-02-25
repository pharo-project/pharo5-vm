cryptography
primitiveGatherEntropy
	"Primitive. Gather good random entropy from a system source."
	| bufOop bufSize bufPtr okay |
	<export: true>
	<var: 'bufPtr' type: 'void *'>
	(interpreterProxy methodArgumentCount = 1)
		ifFalse:[^interpreterProxy primitiveFail].
	bufOop := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	(interpreterProxy isBytes: bufOop)
		ifFalse:[^interpreterProxy primitiveFail].
	bufSize := interpreterProxy byteSizeOf: bufOop.
	bufPtr := interpreterProxy firstIndexableField: bufOop.
	okay := self cCode: 'ioGatherEntropy(bufPtr, bufSize)' inSmalltalk:[bufPtr. bufSize. false].
	okay ifFalse:[^interpreterProxy primitiveFail].
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1.
	^interpreterProxy pushBool: true.