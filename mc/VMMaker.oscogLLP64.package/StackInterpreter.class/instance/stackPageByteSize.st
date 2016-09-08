stack pages
stackPageByteSize
	"Answer a page size that is a power-of-two and contains a useful number of frames.
	 Room for 256 slots for frames gives around 40 frames a page which is a
	 good compromise between overflow rate and latency in divorcing a page."
	<inline: false>
	| pageBytes largeSize smallSize |
	pageBytes := self stackPageFrameBytes + self stackLimitOffset + self stackPageHeadroom.
	(pageBytes bitAnd: pageBytes - 1) = 0 ifTrue: "= 0 => a power of two"
		[^pageBytes].
	"round up or round down; that is the question.  If rounding down reduces
	 the size by no more than 1/8th round down, otherwise roundup."
	largeSize := 1 << pageBytes highBit.
	smallSize := 1 << (pageBytes highBit - 1).
	self assert: (largeSize > pageBytes and: [pageBytes > smallSize]).
	^(pageBytes - smallSize) <= (smallSize / 8)
		ifTrue: [smallSize]
		ifFalse: [largeSize]