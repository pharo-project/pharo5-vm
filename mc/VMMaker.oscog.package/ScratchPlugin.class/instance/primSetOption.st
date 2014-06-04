serial port
primSetOption
	"Return the given option value for the given serial port."

	| portNum attrNum attrValue result |
	<export: true>
	portNum := interpreterProxy stackIntegerValue: 2.
	attrNum := interpreterProxy stackIntegerValue: 1.
	attrValue := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue: [^ nil].

	result := self cCode: 'SerialPortSetOption(portNum, attrNum, attrValue)'.
	result = -1 ifTrue: [interpreterProxy success: false. ^ 0].

	interpreterProxy pop: 3.  "pop args; leave rcvr on stack"
	^ 0
