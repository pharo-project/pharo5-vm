serial port
primPortCount
	"Answer the number of serial ports."

	| result |
	<export: true>

	result := self cCode: 'SerialPortCount()'.
	result = -1 ifTrue: [interpreterProxy success: false. ^ 0].

	interpreterProxy
		pop: 1 thenPush: (interpreterProxy integerObjectOf: result).  "pop rcvr, push result"
	^ 0
