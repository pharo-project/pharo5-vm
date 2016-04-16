Integer primitives
primNormalizePositive
	| rcvr |
	self debugCode: [self msg: 'primNormalizePositive'].
	rcvr := self primitive: 'primNormalizePositive'.
	(interpreterProxy fetchClassOf: rcvr) == interpreterProxy classLargePositiveInteger ifFalse: [^interpreterProxy primitiveFail].
	^ self normalizePositive: rcvr