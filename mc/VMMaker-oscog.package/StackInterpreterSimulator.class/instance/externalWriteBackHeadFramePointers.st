stack pages
externalWriteBackHeadFramePointers
	self assert: (localFP = framePointer
				or: [localFP = (self frameCallerFP: framePointer)]).
	super externalWriteBackHeadFramePointers