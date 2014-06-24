weakness and ephemerality
nilUnmarkedWeaklingSlotsIn: aWeakling
	"Nil the unmarked slots in aWeakling and
	 answer if any unmarked slots were found."
	| anyUnmarked |
	anyUnmarked := false.
	(self numStrongSlotsOfWeakling: aWeakling) to: (self numSlotsOf: aWeakling) - 1 do:
		[:i| | referent |
		referent := self fetchPointer: i ofObject: aWeakling.
		((self isNonImmediate: referent)
		 and: [self isForwarded: referent]) ifTrue:
			[referent := self fixFollowedField: i ofObject: aWeakling withInitialValue: referent].
		((self isImmediate: referent) or: [self isMarked: referent]) ifFalse:
			[self storePointerUnchecked: i ofObject: aWeakling withValue: nilObj.
			 anyUnmarked := true]].
	^anyUnmarked