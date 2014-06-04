growing/shrinking memory
setLastSegment: segInfo
	"Update after removing a segment.
	 Here we cut back endOfMemory if required."
	<var: #segInfo type: #'SpurSegmentInfo *'>
	| currentEnd |
	<var: #currentEnd type: #usqInt>
	currentEnd := segInfo segLimit - self bridgeSize.
	currentEnd <= endOfMemory ifTrue:
		[endOfMemory := currentEnd.
		 freeOldSpaceStart > currentEnd ifTrue:
			[freeOldSpaceStart :=currentEnd]]