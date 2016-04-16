Integer primitives
primNormalizeNegative
	| rcvr |
	self debugCode: [self msg: 'primNormalizeNegative'].
	rcvr := self primitive: 'primNormalizeNegative'.
	(interpreterProxy fetchClassOf: rcvr) == interpreterProxy classLargeNegativeInteger ifFalse: [^interpreterProxy primitiveFail].
	^ self normalizeNegative: rcvr