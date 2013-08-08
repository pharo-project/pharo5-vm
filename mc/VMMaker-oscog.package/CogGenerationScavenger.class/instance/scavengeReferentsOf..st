api
scavengeReferentsOf: referrer
	"scavengeReferentsOf: referrer inspects all the pointers in referrer.
	 If any are new objects, it has them moved to FutureSurvivorSpace,
	 and returns truth. If there are no new referents, it returns falsity."
	<var: #referrer type: #'object *'>
	| foundNewReferent referent |
	referrer isPointers ifFalse:
		[^self].
	foundNewReferent := false.
	0 to: (manager lengthOf: referrer) do:
		[:i|
		referent := manager fetchPointer: i ofObject: referrer.
		(manager isYoung: referent) ifTrue:
			[foundNewReferent := true.
			 referent isForwarded ifFalse:
				[self copyAndForward: referent].
			 manager
				storePointerUnchecked: i
				ofObject: referrer
				withValue: (manager forwardingPointerOf: referent)]].
	^foundNewReferent