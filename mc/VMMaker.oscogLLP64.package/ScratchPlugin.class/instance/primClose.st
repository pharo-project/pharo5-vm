serial port
primClose
	"Close the given serial port."

	| portNum |
	<export: true>
	portNum := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue: [^ nil].

	self cCode: 'SerialPortClose(portNum)'.

	interpreterProxy pop: 1.  "pop arg, leave rcvr on stack"
	^ 0
