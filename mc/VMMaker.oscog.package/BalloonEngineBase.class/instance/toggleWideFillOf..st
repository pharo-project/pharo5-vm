FILL processing
toggleWideFillOf: edge
	| fill type lineWidth depth rightX index |
	<inline: false>
	type := self edgeTypeOf: edge.
	dispatchedValue := edge.
	self dispatchOn: type in: WideLineWidthTable.
	lineWidth := dispatchReturnValue.
	self dispatchOn: type in: WideLineFillTable.
	fill := dispatchReturnValue.
	fill = 0 ifTrue:[^nil].
	(self needAvailableSpace: self stackFillEntryLength) 
		ifFalse:[^nil]. "Make sure we have enough space left"
	depth := (self edgeZValueOf: edge) << 1 + 1. "So lines sort before interior fills"
	rightX := (self edgeXValueOf: edge) + lineWidth.
	index := self findStackFill: fill depth: depth.
	index = -1 ifTrue:[
		self showFill: fill 
			depth: depth
			rightX: rightX.
	] ifFalse:[
		(self stackFillRightX: index) < rightX
			ifTrue:[self stackFillRightX: index put: rightX].
	].
	self quickRemoveInvalidFillsAt: (self edgeXValueOf: edge).