scavenger
copyAndForwardMourner: mourner
	"A special version of copyAndForward: for objects in the mournQueue.  If we're
	 in the good times tenuring regime then copy to futureSpace, otherwise tenure.
	 Also, don't repeat any of the ephemeron processing."
	<inline: false>
	| bytesInObj format tenure newLocation |
	self assert: ((manager isInEden: mourner) "cog methods should be excluded."
				or: [manager isInPastSpace: mourner]).
	bytesInObj := manager bytesInObject: mourner.
	format := manager formatOf: mourner.
	tenure := self shouldMournerBeTenured: mourner. "Allow Slang to inline."
	newLocation := (tenure or: [futureSurvivorStart + bytesInObj > futureSpace limit])
						ifTrue: [self copyToOldSpace: mourner bytes: bytesInObj format: format]
						ifFalse: [self copyToFutureSpace: mourner bytes: bytesInObj].
	manager forwardSurvivor: mourner to: newLocation.
	"if weak or ephemeron add to the relevant list for subsequent scanning."
	(manager isWeakFormat: format) ifTrue:
		[self addToWeakList: mourner].
	^newLocation