serial port
primOpenPortNamed
	"Open the port with the given name and baud rate."

	| nameStr src nameOop baudRate count portNum |
	<export: true>
	<var: 'nameStr' declareC: 'char nameStr[1000]'>
	<var: 'src' type: #'char *'>

	nameOop := interpreterProxy stackValue: 1.
	baudRate := interpreterProxy stackIntegerValue: 0.

	interpreterProxy success: (interpreterProxy isBytes: nameOop).

	interpreterProxy failed ifTrue: [^ 0].

	src := self cCoerce: (interpreterProxy firstIndexableField: nameOop) to: #'char *'.
	count := interpreterProxy stSizeOf: nameOop.
	0 to: count - 1 do: [:i | nameStr at: i put: (src at: i)].
	nameStr at: count put: 0.

	portNum := self SerialPortOpen: nameStr PortNamed: baudRate.
	portNum = -1 ifTrue: [interpreterProxy success: false. ^ 0].

	interpreterProxy	"pop args and rcvr, push result"
		pop: 3
		thenPush: (interpreterProxy integerObjectOf: portNum).

	^ 0
