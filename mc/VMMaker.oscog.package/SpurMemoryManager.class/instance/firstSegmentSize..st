snapshot
firstSegmentSize: firstSegmentSize
	<doNotGenerate>
	"even an empty segment needs a bridge ;-)"
	self assert: firstSegmentSize >= (2 * self baseHeaderSize).
	segmentManager firstSegmentSize: firstSegmentSize