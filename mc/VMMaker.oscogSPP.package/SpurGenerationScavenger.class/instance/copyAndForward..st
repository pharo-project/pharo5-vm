scavenger
copyAndForward: survivor
	"copyAndForward: survivor copies a survivor object either to
	 futureSurvivorSpace or, if it is to be promoted, to oldSpace.
	 It leaves a forwarding pointer behind.  If the object is weak
	 then corpse is threaded onto the weakList for later treatment."
	<inline: false>
	| bytesInObj format tenure newLocation |
	self assert: ((manager isInEden: survivor) "cog methods should be excluded."
				or: [manager isInPastSpace: survivor]).
	bytesInObj := manager bytesInObject: survivor.
	format := manager formatOf: survivor.
	tenure := self shouldBeTenured: survivor. "Allow Slang to inline."
	newLocation := (tenure or: [futureSurvivorStart + bytesInObj > futureSpace limit])
						ifTrue: [self copyToOldSpace: survivor bytes: bytesInObj format: format]
						ifFalse: [self copyToFutureSpace: survivor bytes: bytesInObj].
	manager forwardSurvivor: survivor to: newLocation.
	"if weak or ephemeron add to the relevant list for subsequent scanning."
	(manager isWeakFormat: format) ifTrue:
		[self addToWeakList: survivor].
	((manager isEphemeronFormat: format)
	 and: [(self isScavengeSurvivor: (manager keyOfEphemeron: newLocation)) not]) ifTrue:
		[self addToEphemeronList: survivor].
	^newLocation