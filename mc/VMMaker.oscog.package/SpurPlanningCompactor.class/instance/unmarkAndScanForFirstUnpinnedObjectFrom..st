compaction
unmarkAndScanForFirstUnpinnedObjectFrom: initialObject
	"Scan from initialObject, unmarking any marked pinned objects, and answering the first mobile or freeable object found, or nil if none."
	manager allOldSpaceEntitiesFrom: initialObject do:
		[:o|
		((manager isMarked: o) and: [manager isPinned: o]) ifFalse:
			[^o].
		self unmarkPinned: o].
	^nil