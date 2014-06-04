compaction
inSortedFreeListLink: freeChunk to: nextFree given: prevFree
	"thisContext sender selector = #sweepToCoallesceFreeSpaceForPigCompactFrom: ifTrue:
		[| pit |
			pit := [:label :thing|
					coInterpreter print: label; space; printHex: thing.
					(thing ~= 0 and: [self isFreeObject: thing]) ifTrue:
						[coInterpreter print: ' (free) ']].
			pit value: 'link ' value: freeChunk.
			pit value: ' to ' value: nextFree.
			pit value: ' from ' value: prevFree.
			coInterpreter cr]."
	"freeChunk = 16r10B0730 ifTrue:
		[self halt]."
	super inSortedFreeListLink: freeChunk to: nextFree given: prevFree