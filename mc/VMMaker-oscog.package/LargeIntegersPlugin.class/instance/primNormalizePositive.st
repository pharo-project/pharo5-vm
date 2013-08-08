Integer primitives
primNormalizePositive
	| rcvr |
	self debugCode: [self msg: 'primNormalizePositive'].
	rcvr := self
				primitive: 'primNormalizePositive'
				parameters: #()
				receiver: #LargePositiveInteger.
	^ self normalizePositive: rcvr