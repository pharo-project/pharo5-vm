gc - global
initializeUnscannedEphemerons
	"Initialize unscannedEphemerons to use the largest free chunk
	 or unused eden space, which ever is the larger."
	
	| largestFree sizeOfUnusedEden |
	largestFree := self findLargestFreeChunk.
	sizeOfUnusedEden := scavenger eden limit - freeStart.
	(largestFree notNil
	 and: [(self numSlotsOfAny: largestFree) > (sizeOfUnusedEden / self wordSize)])
		ifTrue:
			[unscannedEphemerons
				start: largestFree
					+ self baseHeaderSize
					+ (self freeChunkLargerIndex + 1 * self wordSize);
				limit: (self addressAfter: largestFree)]
		ifFalse:
			[unscannedEphemerons
				start: freeStart;
				limit: scavenger eden limit].
	unscannedEphemerons top: unscannedEphemerons start