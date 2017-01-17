FILL processing
showFill: fillIndex depth: depth rightX: rightX
	<inline: false>
	(self allocateStackFillEntry) ifFalse:[^nil]. "Insufficient space"
	self stackFillValue: 0 put: fillIndex.
	self stackFillDepth: 0 put: depth.
	self stackFillRightX: 0 put: rightX.
	self stackFillSize = self stackFillEntryLength ifTrue:[^nil]. "No need to update"

	(self fillSorts: 0 before: self stackFillSize - self stackFillEntryLength) ifTrue:[
		"New top fill"
		self stackFillValue: 0 put: self topFillValue.
		self stackFillDepth: 0 put: self topFillDepth.
		self stackFillRightX: 0 put: self topFillRightX.
		self topFillValuePut: fillIndex.
		self topFillDepthPut: depth.
		self topFillRightXPut: rightX.
	].