converting
asCArrayAccessorUnitSize: requiredUnitSize
	self assert: ptrOffset = 0.
	^CArrayAccessor on: (requiredUnitSize = unitSize
								ifTrue: [self]
								ifFalse: [self shallowCopy unitSize: requiredUnitSize])