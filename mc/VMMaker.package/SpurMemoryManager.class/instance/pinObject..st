primitive support
pinObject: objOop
	| oldClone seg |
	<var: #seg type: #'SpurSegmentInfo *'>
	self assert: (self isNonImmediate: objOop).
	self flag: 'policy decision here. if already old, do we clone in a segment containing pinned objects or merely pin?'.
	"We choose to clone to keep pinned objects together to reduce fragmentation,
	 assuming that pinning is rare and that fragmentation is a bad thing."
	(self isOldObject: objOop) ifTrue:
		[seg := segmentManager segmentContainingObj: objOop.
		 seg containsPinned ifTrue:
			[self setIsPinnedOf: objOop to: true.
			 ^0].
		 segmentManager someSegmentContainsPinned ifFalse:
			[self setIsPinnedOf: objOop to: true.
			 seg containsPinned: true.
			 ^0]].
	oldClone := self cloneInOldSpaceForPinning: objOop.
	oldClone = 0 ifTrue:
		[^PrimErrNoMemory].
	self setIsPinnedOf: oldClone to: true.
	self forward: objOop to: oldClone.
	^0