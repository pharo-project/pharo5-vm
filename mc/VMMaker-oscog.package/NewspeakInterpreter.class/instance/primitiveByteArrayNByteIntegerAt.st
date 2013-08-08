array and stream primitive support
primitiveByteArrayNByteIntegerAt
	"Return a (signed or unsigned) n byte integer from the given byte offset."
	| isSigned byteSize byteOffset rcvr addr value mask |
	<export: true>
	<inline: false>
	isSigned := self booleanValueOf: (self stackValue: 0).
	byteSize := self stackIntegerValue: 1.
	byteOffset := self stackIntegerValue: 2.
	self failed ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackObjectValue: 3.
	self failed ifTrue:
		[^self primitiveFailFor: PrimErrInappropriate].
	(byteOffset > 0 and:[byteSize = 1 or:[byteSize = 2 or:[byteSize = 4]]])
		ifFalse:[^self primitiveFailFor: PrimErrBadArgument].
	addr := self addressOf: rcvr startingAt: byteOffset size: byteSize.
	self failed ifTrue:[^0].
	byteSize < 4 ifTrue:[
		"short/byte"
		byteSize = 1 
			ifTrue:[value := self byteAt: addr]
			ifFalse:[value := self cCode: '*((unsigned short int *) addr)' 
								inSmalltalk: [self shortAt: addr]].
		isSigned ifTrue:["sign extend value"
			mask := 1 << (byteSize * 8 - 1).
			value := (value bitAnd: mask-1) - (value bitAnd: mask)].
		"note: byte/short never exceed SmallInteger range"
		value := self integerObjectOf: value.
	] ifFalse:[
		"general 32 bit integer"
		value := self longAt: addr.
		isSigned
			ifTrue:[value := self signed32BitIntegerFor: value]
			ifFalse:[value := self positive32BitIntegerFor: value].
	].
	self pop: 4.
	^self push: value
