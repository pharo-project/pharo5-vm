weakness and ephemerality
nilUnmarkedWeaklingSlotsIn: aWeakling
	"Nil the unmarked slots in aWeakling and
	 answer if any unmarked slots were found."
	<inline: true>
	| anyUnmarked |
	anyUnmarked := false.
	self assert: (self allStrongSlotsOfWeaklingAreMarked: aWeakling).
	"N.B. generateToByDoLimitExpression:negative:on: guards against (unsigned)0 - 1 going +ve"
	(self numStrongSlotsOfWeakling: aWeakling) to: (self numSlotsOf: aWeakling) - 1 do:
		[:i| | referent |
		referent := self fetchPointer: i ofObject: aWeakling.
		(self isNonImmediate: referent) ifTrue:
			[(self isUnambiguouslyForwarder: referent) ifTrue:
				[referent := self fixFollowedField: i ofObject: aWeakling withInitialValue: referent].
			 ((self isImmediate: referent) or: [self isMarked: referent]) ifFalse:
				[self storePointerUnchecked: i ofObject: aWeakling withValue: nilObj.
				 anyUnmarked := true]]].
	^anyUnmarked