weakness and ephemerality
processWeakSurvivor: weakObj
	"Process a weak survivor on the weakList.  Those of its fields
	 which have not survived the scavenge should be nilled, and if any
	 are, the coInterpreter should be informed via fireFinalization:.
	 Answer if the weakObj has any young referents."
	| weakObjShouldMourn hasYoungReferents numStrongSlots  |
	weakObjShouldMourn := hasYoungReferents := false.
	"N.B. generateToByDoLimitExpression:negative:on: guards against (unsigned)0 - 1 going +ve"
	numStrongSlots := manager numFixedSlotsOf: weakObj.
	0 to: numStrongSlots - 1 do:
		[:i| | referent |
		 referent := manager fetchPointer: i ofObject: weakObj.
		 ((manager isNonImmediate: referent)
		  and: [manager isYoungObject: referent]) ifTrue:
			[hasYoungReferents := true]].
	numStrongSlots
		to: (manager numSlotsOf: weakObj) - 1
		do: [:i| | referent |
			referent := manager fetchPointer: i ofObject: weakObj.
			"Referent could be forwarded due to scavenging or a become:, don't assume."
			(manager isNonImmediate: referent) ifTrue:
				[(manager isForwarded: referent) ifTrue:
					[referent := manager followForwarded: referent.
					 "weakObj is either young or already in remembered table; no need to check"
					 self assert: ((manager isReallyYoungObject: weakObj)
								or: [manager isRemembered: weakObj]).
					 manager storePointerUnchecked: i ofObject: weakObj withValue: referent].
				(self isMaybeOldScavengeSurvivor: referent)
					ifTrue:
						[(manager isYoungObject: referent) ifTrue:
							[hasYoungReferents := true]]
					ifFalse:
						[weakObjShouldMourn := true.
						 manager
							storePointerUnchecked: i
							ofObject: weakObj
							withValue: manager nilObject]]].
	weakObjShouldMourn ifTrue:
		[coInterpreter fireFinalization: weakObj].
	^hasYoungReferents