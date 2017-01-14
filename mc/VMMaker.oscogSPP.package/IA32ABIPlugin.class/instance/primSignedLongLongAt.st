primitives-accessing
primSignedLongLongAt
	"Answer the signed 64-bit integer starting at the given byte offset (little endian)."
	"<Alien> signedLongLongAt: index <Integer> ^<Integer>
		<primitive: 'primSignedLongLongAt' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr valueOop signedlonglongvaluePtr signedlonglongvalue |
	<export: true>
	<var: 'signedlonglongvalue' declareC: 'long long signedlonglongvalue'>
	<var: 'signedlonglongvaluePtr' declareC: 'long long *signedlonglongvaluePtr'>

	signedlonglongvaluePtr := 0.
	self touch: signedlonglongvaluePtr.
	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 0) - 1.
	rcvr := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: 8 inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	(startAddr := self startOfData: rcvr) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	addr := startAddr + byteOffset.
	signedlonglongvaluePtr := self cCoerce: addr to: 'long long*'.
	signedlonglongvalue := self cCode: '*signedlonglongvaluePtr'.
	valueOop := interpreterProxy signed64BitIntegerFor: signedlonglongvalue.
	^interpreterProxy methodReturnValue: valueOop