snapshot
imageSizeToWrite
	"when asked, newSpace should be empty."
	self assert: self newSpaceIsEmpty.
	^segmentManager totalBytesInNonEmptySegments