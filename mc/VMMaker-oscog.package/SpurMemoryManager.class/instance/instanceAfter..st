object enumeration
instanceAfter: objOop
	| actualObj classIndex |
	actualObj := objOop.
	classIndex := self classIndexOf: objOop.

	(self isInEden: objOop) ifTrue:
		[[actualObj := self objectAfter: actualObj limit: freeStart.
		  actualObj < freeStart] whileTrue:
			[classIndex = (self classIndexOf: actualObj) ifTrue:
				[^actualObj]].
		 actualObj := pastSpaceStart > scavenger pastSpace start
						ifTrue: [self objectStartingAt: scavenger pastSpace start]
						ifFalse: [nilObj]].

	(self isInSurvivorSpace: actualObj) ifTrue:
		[[actualObj := self objectAfter: actualObj limit: pastSpaceStart.
		  actualObj < pastSpaceStart] whileTrue:
			[classIndex = (self classIndexOf: actualObj) ifTrue:
				[^actualObj]].
		 actualObj := nilObj].

	[actualObj := self objectAfter: actualObj limit: freeOldSpaceStart.
	 actualObj < freeOldSpaceStart] whileTrue:
		[classIndex = (self classIndexOf: actualObj) ifTrue:
			[^actualObj]].
	^nil