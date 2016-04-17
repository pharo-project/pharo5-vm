Integer primitives
primNormalizeNegative
	| rcvr |
	self debugCode: [self msg: 'primNormalizeNegative'].
	rcvr := self
				primitive: 'primNormalizeNegative'
				parameters: #()
				receiver: #LargeNegativeInteger.
	^ self normalizeNegative: rcvr