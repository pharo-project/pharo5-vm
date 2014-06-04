growing/shrinking memory
assimilateNewSegment: segInfo
	"Update after adding a segment.
	 Here we set freeOldSpaceStart & endOfMemory if required."
	<var: #segInfo type: #'SpurSegmentInfo *'>
	segInfo segLimit >= endOfMemory ifTrue:
		[freeOldSpaceStart :=
		 endOfMemory := segInfo segLimit - self bridgeSize]