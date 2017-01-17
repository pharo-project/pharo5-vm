debug support
checkSegments
	self assert: numSegments >= 1.
	0 to: numSegments - 1 do:
		[:i|
		self assert: (manager addressCouldBeObj: (segments at: i) segStart).
		self assert: (self isValidSegmentBridge: (self bridgeAt: i))].
	self assert: (segments at: numSegments - 1) segLimit - manager bridgeSize = manager endOfMemory