serial port
primGetOption
	"Return the given option value for the given serial port."

	| portNum attrNum result |
	<export: true>
	portNum := interpreterProxy stackIntegerValue: 1.
	attrNum := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue: [^ nil].

	result := self cCode: 'SerialPortGetOption(portNum, attrNum)'.
	result = -1 ifTrue: [interpreterProxy success: false. ^ 0].

	interpreterProxy pop: 3.  "pop args and rcvr, push result"
	interpreterProxy pushInteger: result.
	^ 0
