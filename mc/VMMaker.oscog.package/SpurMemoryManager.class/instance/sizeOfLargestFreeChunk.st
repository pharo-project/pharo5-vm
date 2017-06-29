free space
sizeOfLargestFreeChunk
	"Answer the size of largest free chunk in oldSpace."
	| freeChunk |
	freeChunk := self findLargestFreeChunk.
	freeChunk ifNil:
		[63 to: 1 by: -1 do:
			[:i|
			(freeLists at: i) ifNotNil:
				[:chunk| ^self bytesInObject: chunk]].
		 ^0].
	^self bytesInObject: freeChunk