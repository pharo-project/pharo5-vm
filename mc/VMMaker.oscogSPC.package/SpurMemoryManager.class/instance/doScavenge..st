gc - scavenging
doScavenge: tenuringCriterion
	"The inner shell for scavenge, abstrascted out so globalGarbageCollect can use it."
	<inline: false>
	gcPhaseInProgress := ScavengeInProgress.
	pastSpaceStart := scavenger scavenge: tenuringCriterion.
	self assert: (self
					oop: pastSpaceStart
					isGreaterThanOrEqualTo: scavenger pastSpace start
					andLessThanOrEqualTo: scavenger pastSpace limit).
	freeStart := scavenger eden start.
	self initSpaceForAllocationCheck: (self addressOf: scavenger eden) limit: scavengeThreshold.
	gcPhaseInProgress := 0