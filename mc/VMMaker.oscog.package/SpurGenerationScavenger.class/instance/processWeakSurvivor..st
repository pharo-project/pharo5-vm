weakness and ephemerality
processWeakSurvivor: weakObj
	"Process a weak survivor on the weakList.  Those of its fields
	 which have not survived the scavenge should be nilled, and if any
	 are, the coInterpreter should be informed via signalFinalization:."
	| weakObjShouldMourn |
	weakObjShouldMourn := false.
	(manager numFixedSlotsOf: weakObj)
		to: (manager numSlotsOf: weakObj) - 1
		do: [:i| | referent |
			referent := manager fetchPointer: i ofObject: weakObj.
			"Referent could be forwarded due to scavenging or a become:, don't assume."
			((manager isNonImmediate: referent)
			and: [manager isForwarded: referent]) ifTrue:
				[referent := manager followForwarded: referent.
				 (self isScavengeSurvivor: referent) ifTrue:
					[manager storePointer: i ofObject: weakObj withValue: referent]].
			(self isScavengeSurvivor: referent)
				ifFalse:
					[weakObjShouldMourn := true.
					 manager
						storePointerUnchecked: i
						ofObject: weakObj
						withValue: manager nilObject]
				ifTrue:
					[self assert: referent = (manager fetchPointer: i ofObject: weakObj)]].
	weakObjShouldMourn ifTrue:
		[coInterpreter signalFinalization: weakObj]