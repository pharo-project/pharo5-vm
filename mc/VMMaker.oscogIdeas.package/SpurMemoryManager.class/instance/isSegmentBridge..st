segments
isSegmentBridge: objOop
	"Maybe this should be in SpurSegmentManager only"
	^(self classIndexOf: objOop) = self segmentBridgePun