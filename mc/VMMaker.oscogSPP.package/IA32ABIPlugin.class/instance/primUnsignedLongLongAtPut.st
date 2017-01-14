primitives-accessing
primUnsignedLongLongAtPut
	"Store a signed integer into 64 bits starting at the given byte offset (little endian)."
	"<Alien> unsignedLongLongAt: index <Integer> put: value <Integer> ^<Integer>
		<primitive: 'primUnSignedLongLongAtPut' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr valueOop unsignedlonglongvalue unsignedlonglongvaluePtr |
	<export: true>
	<var: 'unsignedlonglongvalue' declareC: 'unsigned long long unsignedlonglongvalue'>
	<var: 'unsignedlonglongvaluePtr' declareC: 'unsigned long long *unsignedlonglongvaluePtr'>

	unsignedlonglongvaluePtr := 0.
	self touch: unsignedlonglongvaluePtr.

	valueOop := interpreterProxy stackValue: 0.
	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 1) - 1.
	rcvr := interpreterProxy stackObjectValue: 2.
	unsignedlonglongvalue := interpreterProxy positive64BitValueOf: valueOop.
	self touch: unsignedlonglongvalue.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: 8 inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	(interpreterProxy isOopImmutable: rcvr) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoModification].
	(startAddr := self startOfData: rcvr) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	addr := startAddr + byteOffset.
	unsignedlonglongvaluePtr := self cCoerce: addr to: 'unsigned long long*'.
	self cCode: '*unsignedlonglongvaluePtr = unsignedlonglongvalue'.
	^interpreterProxy methodReturnValue: valueOop