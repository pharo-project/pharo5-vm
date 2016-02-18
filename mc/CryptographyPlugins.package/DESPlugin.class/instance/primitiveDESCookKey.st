primitives
primitiveDESCookKey
	"preprocess the key to more useful format

	param1 = raw key: ByteArray[8]
	param2 = 1->encode 0->decode
	param3 = cooked key:  WordArray[32]"

	| raw cooked encode |
	<export: true>
	<var: 'raw' declareC: 'unsigned char *raw'>
	<var: 'cooked' declareC: 'unsigned long *cooked'>
	interpreterProxy methodArgumentCount = 3
		ifFalse:[^interpreterProxy primitiveFail].
	raw := self checkedBytePtrOf: (interpreterProxy stackValue: 2).
	encode := interpreterProxy stackIntegerValue: 1.
	cooked := self checkedWordPtrOf: (interpreterProxy stackValue: 0).
	interpreterProxy failed
		ifTrue: [ ^nil ].
	self processKey: raw mode: encode to: cooked.
	interpreterProxy pop: 3
	