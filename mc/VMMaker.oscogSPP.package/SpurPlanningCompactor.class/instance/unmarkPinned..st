private
unmarkPinned: pinnedObj
	<inline: true>
	(manager isSegmentBridge: pinnedObj) ifFalse:
		[manager setIsMarkedOf: pinnedObj to: false.
		 manager segmentManager notePinned: pinnedObj]