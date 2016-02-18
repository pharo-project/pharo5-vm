object enumeration
instanceAfter: objOop
	| actualObj classIndex |
	actualObj := objOop.
	classIndex := self classIndexOf: objOop.

	(self isInEden: objOop) ifTrue:
		[[actualObj := self objectAfter: actualObj limit: freeStart.
		  self oop: actualObj isLessThan: freeStart] whileTrue:
			[classIndex = (self classIndexOf: actualObj) ifTrue:
				[^actualObj]].
		 actualObj := (self oop: pastSpaceStart isGreaterThan: scavenger pastSpace start)
						ifTrue: [self objectStartingAt: scavenger pastSpace start]
						ifFalse: [nilObj]].

	(self isInPastSpace: actualObj) ifTrue:
		[[actualObj := self objectAfter: actualObj limit: pastSpaceStart.
		  self oop: actualObj isLessThan: pastSpaceStart] whileTrue:
			[classIndex = (self classIndexOf: actualObj) ifTrue:
				[^actualObj]].
		 actualObj := nilObj].

	[actualObj := self objectAfter: actualObj limit: endOfMemory.
	 self oop:actualObj isLessThan: endOfMemory] whileTrue:
		[classIndex = (self classIndexOf: actualObj) ifTrue:
			[^actualObj]].
	^nil