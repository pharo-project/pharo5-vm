array and stream primitive support
primitiveByteArrayDoubleAtPut
	"Store a Double at given byte offset in a ByteArray."
	| byteOffset rcvr addr floatValue floatOop |
	<export: true>
	<inline: false>
	<var: #floatValue type:'double '>
	floatOop := self stackValue: 0.
	(self isIntegerObject: floatOop)
		ifTrue:[floatValue := self cCoerce: (self integerValueOf: floatOop) to:'double']
		ifFalse:[floatValue := self cCoerce: (self floatValueOf: floatOop) to:'double'].
	byteOffset := self stackIntegerValue: 1.
	self failed ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackObjectValue: 2.
	self failed ifTrue:[^self primitiveFailFor: PrimErrInappropriate].
	addr := self addressOf: rcvr startingAt: byteOffset size: 8.
	self failed ifTrue:[^0].
	(self isOopImmutable: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].
	self cCode:'((int*)addr)[0] = ((int*)(&floatValue))[0]'.
	self cCode:'((int*)addr)[1] = ((int*)(&floatValue))[1]'.
	self pop: 3.
	^self push: floatOop