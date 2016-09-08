weakness and ephemerality
allWeakSurvivorsOnWeakList
	self allFutureSpaceEntitiesDo:
		[:survivor|
		(manager isWeakNonImm: survivor) ifTrue:
			[(self is: survivor onWeaklingList: weakList) ifFalse:
				[^false]]].
	^true