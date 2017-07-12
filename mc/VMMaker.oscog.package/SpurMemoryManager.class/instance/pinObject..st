primitive support
pinObject: objOop
	"Attempt to pin objOop, which must not be immediate.
	 If the attempt succeeds answer objOop's (possibly moved) oop.
	 If the attempt fails, which can only occur if there is no memory, answer 0."
	<inline: false>
	| oldClone seg |
	<var: #seg type: #'SpurSegmentInfo *'>
	self assert: (self isNonImmediate: objOop).
	self flag: 'policy decision here. if already old, do we clone in a segment containing pinned objects or merely pin?'.
	"We choose to clone to keep pinned objects together to reduce fragmentation,
	 if the object is not too large, assuming that pinning is rare and that fragmentation is a bad thing.
	 Too large is defined as over 1mb.  The size of a 640x480x4 bitmap is 1228800."
	(self isOldObject: objOop) ifTrue:
		[(self numBytesOf: objOop) > (1024 * 1024) ifTrue:
			[self setIsPinnedOf: objOop to: true.
			 ^objOop].
		 seg := segmentManager segmentContainingObj: objOop.
		 seg containsPinned ifTrue:
			[self setIsPinnedOf: objOop to: true.
			 ^objOop].
		 segmentManager someSegmentContainsPinned ifFalse:
			[self setIsPinnedOf: objOop to: true.
			 seg containsPinned: true.
			 ^objOop]].
	oldClone := self cloneInOldSpace: objOop forPinning: true.
	oldClone ~= 0 ifTrue:
		[becomeEffectsFlags := self becomeEffectFlagsFor: objOop.
		 self setIsPinnedOf: oldClone to: true.
		 self forward: objOop to: oldClone.
		 self followSpecialObjectsOop.
		 coInterpreter postBecomeAction: becomeEffectsFlags.
		 self postBecomeScanClassTable: becomeEffectsFlags.
		 becomeEffectsFlags := 0].
	^oldClone