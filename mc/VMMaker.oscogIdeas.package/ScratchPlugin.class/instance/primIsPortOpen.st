serial port
primIsPortOpen
	"Answer the true if the given port is open."

	| portNum result |
	<export: true>
	portNum := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue: [^ 0].

	result := self cCode: 'SerialPortIsOpen(portNum)'.

	interpreterProxy pop: 2.  "pop arg and rcvr"
	interpreterProxy pushBool: result ~= 0.  "push result"
	^ 0
