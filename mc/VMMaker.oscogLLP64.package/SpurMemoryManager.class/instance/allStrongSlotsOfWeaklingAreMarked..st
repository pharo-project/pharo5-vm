weakness and ephemerality
allStrongSlotsOfWeaklingAreMarked: aWeakling
	"N.B. generateToByDoLimitExpression:negative:on: guards against (unsigned)0 - 1 going +ve"
	0 to: (self numStrongSlotsOfWeakling: aWeakling) - 1 do:
		[:i| | referent |
		referent := self fetchPointer: i ofObject: aWeakling.
		(self isNonImmediate: referent) ifTrue:
			[(self isMarked: referent) ifFalse:
				[^false]]].
	^true