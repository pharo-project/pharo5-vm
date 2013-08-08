object access primitives
primitiveGetImmutability
	| rcvr hdr |
	rcvr := self stackValue: 0.
	(self isIntegerObject: rcvr)
		ifTrue:
			[self pop: argumentCount thenPush: (self splObj: TrueObject)]
		ifFalse:
			[hdr := self baseHeader: rcvr.
			self pop: argumentCount thenPushBool: (hdr bitAnd: ImmutabilityBit) ~= 0]