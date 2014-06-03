array and stream primitive support
primitiveByteArrayFloatAtPut
	"Store a Float at the given byteOffset in a ByteArray"
	| byteOffset rcvr addr floatValue floatOop |
	<export: true>
	<inline: false>
	<var: #floatValue type:'float '>
	floatOop := self stackValue: 0.
	(self isIntegerObject: floatOop)
		ifTrue:[floatValue := self cCoerce: (self integerValueOf: floatOop) to:'float']
		ifFalse:[floatValue := self cCoerce: (self floatValueOf: floatOop) to:'float'].
	byteOffset := self stackIntegerValue: 1.
	self failed ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackObjectValue: 2.
	self failed ifTrue:
		[^self primitiveFailFor: PrimErrInappropriate].
	addr := self addressOf: rcvr startingAt: byteOffset size: 4.
	self failed ifTrue:[^0].
	(self isOopImmutable: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].
	self cCode:'((int*)addr)[0] = ((int*)(&floatValue))[0]'.
	self pop: 3.
	^self push: floatOop