primitives
primitiveDESTransform
	"encrypt/decrypt some data

	param1 = data key: ByteArray[8]
	param2 = cooked key:  WordArray[32]"

	| data work cooked |
	<export: true>
	<var: 'data' declareC: 'unsigned char *data'>
	<var: 'cooked' declareC: 'unsigned long *cooked'>
	<var: 'work' declareC: 'unsigned long work[2]'>
	self cCode: '/* Hi ho, Hi ho...*/' inSmalltalk: [work := 1].
	interpreterProxy methodArgumentCount = 2
		ifFalse:[^interpreterProxy primitiveFail].
	data := self checkedBytePtrOf: (interpreterProxy stackValue: 1).
	cooked := self checkedWordPtrOf: (interpreterProxy stackValue: 0).
	interpreterProxy failed
		ifTrue: [ ^nil ].
	self scrunch: data to: work.
	self encrypt: work with: cooked.
	self unscrunch: work to: data.
	interpreterProxy pop: 2
	