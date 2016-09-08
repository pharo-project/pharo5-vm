growing/shrinking memory
insertSegmentFor: segAddress
	"Reserve a new segInfo for segAddress.  If segAddress
	 is in the middle of the existing segments, shuffle them
	 up to make room. Answer the new segment's index."
	| segIndex lastSegIndex |
	self assert: segAddress >= (segments at: 0) segLimit.
	numSegments = numSegInfos ifTrue:
		[self allocateOrExtendSegmentInfos].
	self assert: numSegments < numSegInfos.
	segIndex := lastSegIndex := numSegments - 1.
	numSegments := numSegments + 1.
	[segAddress >= (segments at: segIndex) segLimit ifTrue:
		[segIndex := segIndex + 1.
		 lastSegIndex to: segIndex by: -1 do:
			[:idx| segments at: idx + 1 put: (segments at: idx)].
		 ^segIndex].
	 segIndex := segIndex - 1]
		repeat