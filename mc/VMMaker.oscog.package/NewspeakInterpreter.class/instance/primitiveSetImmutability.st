object access primitives
primitiveSetImmutability
	| boolean rcvr hdr wasImmutable |
	rcvr := self stackValue: 1.
	(self isIntegerObject: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrInappropriate].
	boolean := self booleanValueOf: self stackTop.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	hdr := self baseHeader: rcvr.
	wasImmutable := hdr bitAnd: ImmutabilityBit.
	boolean
		ifTrue: [hdr := hdr bitOr: ImmutabilityBit]
		ifFalse: [hdr := hdr bitAnd: AllButImmutabilityBit].
	self baseHeader: rcvr put: hdr.
	self pop: argumentCount thenPushBool: wasImmutable ~= 0