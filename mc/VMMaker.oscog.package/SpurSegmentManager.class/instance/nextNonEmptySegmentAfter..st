snapshot
nextNonEmptySegmentAfter: i
	"Answer the the next non-empty segment or nil. The size of a segment includes
	 that of its bridge. A segment containing just a free object and a bridge will still
	 have a size of manager bridgeSize after shortening it in prepareForSnapshot."
	<returnTypeC: #'SpurSegmentInfo *'>
	| nextx |
	nextx := i.
	[(nextx := nextx + 1) >= numSegments ifTrue:
		[^nil].
	 (segments at: nextx) segSize > manager bridgeSize ifTrue:
		[^self addressOf: (segments at: nextx)]] repeat