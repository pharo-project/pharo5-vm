translated prims
primWrite
	"Write data to the WeDo port from the given buffer (a ByteArray or String). Answer the number of bytes written."

	| bufOop bufPtr bufSize byteCount |
	<export: true>
	<var: 'bufPtr' declareC: 'char *bufPtr'>

	bufOop := interpreterProxy stackValue: 0.
	(interpreterProxy isBytes: bufOop) ifFalse: [
		interpreterProxy success: false.
		^ 0].
	bufPtr := self cCoerce: (interpreterProxy firstIndexableField: bufOop) to: 'char *'.
	bufSize := interpreterProxy stSizeOf: bufOop.
	interpreterProxy failed ifTrue: [^ 0].

	byteCount := self cCode: 'WeDoWrite(bufPtr, bufSize)'.
	byteCount < 0 ifTrue: [
		interpreterProxy success: false.
		^ 0].

	interpreterProxy pop: 2.  					"pop args and rcvr"
	interpreterProxy pushInteger: byteCount.	"push result"
	^ 0
