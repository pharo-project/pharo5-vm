primitives-accessing
primSignedLongLongAtPut
	"Store a signed integer into 64 bits starting at the given byte offset (little endian)."
	"<Alien> signedLongLongAt: index <Integer> put: value <Integer> ^<Integer>
		<primitive: 'primSignedLongLongAtPut' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr valueOop signedlonglongvalue signedlonglongvaluePtr |
	<export: true>
	<var: 'signedlonglongvalue' declareC: 'long long signedlonglongvalue'>
	<var: 'signedlonglongvaluePtr' declareC: 'long long *signedlonglongvaluePtr'>

	signedlonglongvaluePtr := 0.
	self touch: signedlonglongvaluePtr.
	valueOop := interpreterProxy stackValue: 0.
	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 1) - 1.
	rcvr := interpreterProxy stackObjectValue: 2.
	signedlonglongvalue := interpreterProxy signed64BitValueOf: valueOop.
	self touch: signedlonglongvalue.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: 8 inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	(interpreterProxy isOopImmutable: rcvr) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoModification].
	(startAddr := self startOfData: rcvr) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	addr := startAddr + byteOffset.
	signedlonglongvaluePtr := self cCoerce: addr to: 'long long*'.
	self cCode: '*signedlonglongvaluePtr = signedlonglongvalue'.
	^interpreterProxy methodReturnValue: valueOop