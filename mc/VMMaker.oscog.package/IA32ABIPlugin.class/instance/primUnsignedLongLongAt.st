primitives-accessing
primUnsignedLongLongAt
	"Answer the unsigned 64-bit integer starting at the given byte offset (little endian)."
	"<Alien>unsignedLongLongAt: index <Integer> ^<Integer>
		<primitive: 'primUnsignedLongLongAt' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr valueOop unsignedlonglongvaluePtr unsignedlonglongvalue |
	<export: true>
	<var: 'unsignedlonglongvalue' declareC: 'unsigned long long unsignedlonglongvalue'>
	<var: 'unsignedlonglongvaluePtr' declareC: 'unsigned long long *unsignedlonglongvaluePtr'>

	unsignedlonglongvaluePtr := 0.
	self touch: unsignedlonglongvaluePtr.
	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 0) - 1.
	rcvr := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: 8 inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	(startAddr := self startOfData: rcvr) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	addr := startAddr + byteOffset.
	unsignedlonglongvaluePtr := self cCoerce: addr to: 'unsigned long long*'.
	unsignedlonglongvalue := self cCode: '*unsignedlonglongvaluePtr'.
	valueOop := interpreterProxy positive64BitIntegerFor: unsignedlonglongvalue.
	^interpreterProxy methodReturnValue: valueOop