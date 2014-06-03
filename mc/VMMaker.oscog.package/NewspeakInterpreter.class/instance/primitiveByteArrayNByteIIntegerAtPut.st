array and stream primitive support
primitiveByteArrayNByteIIntegerAtPut
	"Store a (signed or unsigned) n byte integer at the given byte offset."
	| isSigned byteSize byteOffset rcvr addr value max valueOop |
	<export: true>
	<inline: false>
	isSigned := self booleanValueOf: (self stackValue: 0).
	byteSize := self stackIntegerValue: 1.
	valueOop := self stackValue: 2.
	byteOffset := self stackIntegerValue: 3.
	self failed ifTrue:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackObjectValue: 4.
	self failed ifTrue:
		[^self primitiveFailFor: PrimErrInappropriate].
	(byteOffset > 0 and:[byteSize = 1 or:[byteSize = 2 or:[byteSize = 4]]])
		ifFalse:[^self primitiveFailFor: PrimErrBadArgument].
	addr := self addressOf: rcvr startingAt: byteOffset size: byteSize.
	self failed ifTrue:[^0].
	isSigned 
		ifTrue:[value := self signed32BitValueOf: valueOop]
		ifFalse:[value := self positive32BitValueOf: valueOop].
	self failed ifTrue:[^0].
	byteSize < 4
		ifTrue:
			[isSigned ifTrue:[
				max := 1 << (8 * byteSize - 1).
				value >= max ifTrue:[^self primitiveFail].
				value < (0 - max) ifTrue:[^self primitiveFail].
			] ifFalse:[
				value >= (1 << (8*byteSize)) ifTrue:[^self primitiveFail].
			].
			(self isOopImmutable: rcvr) ifTrue:
				[^self primitiveFailFor: PrimErrNoModification].
			"short/byte"
			byteSize = 1 
				ifTrue:[self byteAt: addr put: value]
				ifFalse:[	self cCode: '*((short int *) addr) = value' 
							inSmalltalk: [self shortAt: addr put: value]]]
		ifFalse:
			[(self isOopImmutable: rcvr) ifTrue:
				[^self primitiveFailFor: PrimErrNoModification].
			self longAt: addr put: value].
	self pop: 5.
	^self push: valueOop.