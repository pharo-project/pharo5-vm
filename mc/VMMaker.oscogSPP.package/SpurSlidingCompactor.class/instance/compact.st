compaction - api
compact
	"Sweep all of old space, sliding unpinned marked objects down over free and unmarked objects.
	 Let the segmentManager mark which segments contain pinned objects via notePinned:.
		destination: nil or the start of a run of free and/or unmarked objects
		pinnedObject: nil or the pinned object found in the sweep around which unpinned objects must be copied."
	| destination pinnedObject |
	<inline: #never> "for profiling"
	manager checkFreeSpace: GCModeFull.
	manager resetFreeListHeads.
	self selectCompactedCopySpace.
	destination := pinnedObject := nil.
	manager allOldSpaceEntitiesFrom: manager firstObject do:
		[:o|
		 (manager isMarked: o)
			ifTrue: "forwarders should have been followed in markAndTrace:"
				[self assert: (manager isForwarded: o) not.
				 destination
					ifNil:
						[manager setIsMarkedOf: o to: false.
						 (manager isPinned: o) ifTrue:
							[manager segmentManager notePinned: o]]
					ifNotNil:
						[(manager isPinned: o)
							ifTrue:
								[manager segmentManager notePinned: o.
								 destination := self copyObjectsInCompactedCopySpaceTo: destination followingUpTo: o.
								 (manager startOfObject: o) - destination > manager allocationUnit
									ifTrue: "Possible to move objects below the pinnedObject"
										[pinnedObject
											ifNil: []
											ifNotNil: [].
										 pinnedObject := o]
									ifFalse: "Impossible; ensure there's a free chunk if necessary."
										[pinnedObject
											ifNil: []
											ifNotNil: [].
										 destination := nil]] "WAIT; NEED AT LEAST 2 WORDS FOR FREE CHUNK"
							ifFalse:
								[manager setIsMarkedOf: o to: false.
								 (self fitsInCompactedCopySpace: o) ifFalse:
									[destination := self copyObjectsInCompactedCopySpaceTo: destination followingUpTo: o].
								  (self fitsInCompactedCopySpace: o)
									ifFalse: [destination := self slideHugeObject: o downTo: destination]
									ifTrue:
										[self copyToCompactedCopySpace: o andForwardTargetedAt: destination]]]]
			ifFalse: "unmarked; two cases, an unreachable object or a free chunk. Should be faster to set free than to check if already free..."
				[destination ifNil: [destination := manager startOfObject: o].
				 manager setObjectFree: o]]