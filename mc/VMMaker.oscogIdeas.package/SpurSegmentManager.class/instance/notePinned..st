pinning
notePinned: objOop
	"Let the segmentManager mark which segments contain pinned objects"
	self assert: (manager isPinned: objOop).
	(manager isSegmentBridge: objOop)
		ifTrue:
			[manager setIsMarkedOf: objOop to: true]
		ifFalse:
			[[self oop: (segments at: sweepIndex) segLimit isLessThan: objOop] whileTrue:
				[sweepIndex := sweepIndex + 1].
			 (segments at: sweepIndex) containsPinned: true]