primitive support
unmarkAllObjects
	self allHeapEntitiesDo:
		[:obj|
		 (self isMarked: obj) ifTrue:
			[(self isNormalObject: obj)
				ifTrue:
					[self setIsMarkedOf: obj to: false]
				ifFalse:
					[(self isSegmentBridge: obj) ifFalse:
						[self setIsMarkedOf: obj to: false]]]].
