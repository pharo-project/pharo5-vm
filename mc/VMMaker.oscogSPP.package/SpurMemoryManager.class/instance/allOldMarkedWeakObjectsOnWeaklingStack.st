weakness and ephemerality
allOldMarkedWeakObjectsOnWeaklingStack
	self allOldSpaceEntitiesDo:
		[:o|
		((self isWeakNonImm: o)
		 and: [self isMarked: o]) ifTrue:
			[(self is: o onObjStack: weaklingStack) ifFalse:
				[^false]]].
	^true