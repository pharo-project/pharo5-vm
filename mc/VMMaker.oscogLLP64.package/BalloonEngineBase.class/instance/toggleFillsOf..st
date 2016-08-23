FILL processing
toggleFillsOf: edge
	| depth fillIndex |
	<inline: false>

	(self needAvailableSpace: self stackFillEntryLength * 2) 
		ifFalse:[^nil]. "Make sure we have enough space left"
	depth := (self edgeZValueOf: edge) << 1.
	fillIndex := self edgeLeftFillOf: edge.
	fillIndex = 0 ifFalse:[self toggleFill: fillIndex depth: depth rightX: 999999999].
	fillIndex := self edgeRightFillOf: edge.
	fillIndex = 0 ifFalse:[self toggleFill: fillIndex depth: depth rightX: 999999999].
	self quickRemoveInvalidFillsAt: (self edgeXValueOf: edge).