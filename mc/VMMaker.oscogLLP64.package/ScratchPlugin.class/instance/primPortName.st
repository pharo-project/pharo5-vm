serial port
primPortName
	"Get the name for the port with the given number. Fail if the port number is greater than the number of available ports. Port numbering starts with 1."

	| portIndex nameStr count resultOop dst |
	<export: true>
	<var: 'nameStr' declareC: 'char nameStr[1000]'>
	<var: 'dst' declareC: 'char* dst'>

	portIndex := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue: [^ 0].

	self cCode: 'SerialPortName(portIndex, nameStr, 1000)'.

	count := self cCode: 'strlen(nameStr)'.
	count = 0 ifTrue: [
		interpreterProxy success: false.
		^ 0].

	resultOop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: count.
	dst := self cCoerce: (interpreterProxy firstIndexableField: resultOop) to: 'char *'.
	0 to: count - 1 do: [:i | dst at: i put: (nameStr at: i)].

	interpreterProxy pop: 2 thenPush: resultOop.  "pop arg and rcvr, push result"
	^ 0
