Integer primitives
primAnyBitFrom: from to: to 
	| integer large |
	self debugCode: [self msg: 'primAnyBitFrom: from to: to'].
	integer := self
				primitive: 'primAnyBitFromTo'
				parameters: #(#SmallInteger #SmallInteger )
				receiver: #Integer.
	(interpreterProxy isIntegerObject: integer)
		ifTrue: ["convert it to a not normalized LargeInteger"
			large := self createLargeFromSmallInteger: integer]
		ifFalse: [large := integer].
	^ (self
		anyBitOfLargeInt: large
		from: from
		to: to)
		asOop: Boolean