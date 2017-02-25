debug support
allBridgesMarked
	0 to: numSegments - 1 do:
		[:i| | bridgeObj |
		 bridgeObj := self bridgeAt: i.
		 self assert: (self isValidSegmentBridge: bridgeObj).
		 (manager isMarked: bridgeObj) ifFalse:
			[^false]].
	^true

	"for debugging:"
	"(0 to: numSegments - 1) select:
		[:i| | bridgeObj |
		 bridgeObj := self bridgeAt: i.
		 self assert: (self isValidSegmentBridge: bridgeObj).
		 manager isMarked: bridgeObj]"