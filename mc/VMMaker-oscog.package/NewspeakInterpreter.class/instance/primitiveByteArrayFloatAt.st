array and stream primitive support
primitiveByteArrayFloatAt
	"Return a Float from the given byte offset in a ByteArray."
	| byteOffset rcvr addr floatValue |
	<export: true>
	<inline: false>
	<var: #floatValue type:'float '>
	byteOffset := self stackIntegerValue: 0.
	self failed ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackObjectValue: 1.
	self failed ifTrue:
		[^self primitiveFailFor: PrimErrInappropriate].
	addr := self addressOf: rcvr startingAt: byteOffset size: 4.
	self failed ifTrue:[^0].
	self cCode:'((int*)(&floatValue))[0] = ((int*)addr)[0]'.
	self pop: 2.
	^self pushFloat: floatValue