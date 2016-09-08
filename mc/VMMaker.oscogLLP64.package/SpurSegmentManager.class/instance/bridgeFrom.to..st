growing/shrinking memory
bridgeFrom: aSegment to: nextSegmentOrNil
	"Create a bridge from aSegment to the next segment,
	 or create a terminating bridge if there is no next segment."
	<var: #aSegment type: #'SpurSegmentInfo *'>
	<var: #nextSegmentOrNil type: #'SpurSegmentInfo *'>
	| segEnd clifton bridgeSpan |
	segEnd := aSegment segLimit.
	clifton := segEnd - manager bridgeSize. "clifton is where the Avon bridge begins..."
	bridgeSpan := nextSegmentOrNil
					ifNil: [manager bridgeSize]
					ifNotNil: [nextSegmentOrNil segStart - segEnd + manager bridgeSize].
	manager initSegmentBridgeWithBytes: bridgeSpan at: clifton.
	"the revised bridge should get us to the new segment"
	self assert: (manager addressAfter: (manager objectStartingAt: clifton))
				= (nextSegmentOrNil
						ifNil: [aSegment segLimit]
						ifNotNil: [nextSegmentOrNil segStart])
