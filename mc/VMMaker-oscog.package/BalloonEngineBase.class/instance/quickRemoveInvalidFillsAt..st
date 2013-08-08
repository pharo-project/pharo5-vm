FILL processing
quickRemoveInvalidFillsAt: leftX
	"Remove any top fills if they have become invalid."
	self stackFillSize = 0 ifTrue:[^nil].
	[self topRightX <= leftX] whileTrue:[
		self hideFill: self topFill depth: self topDepth.
		self stackFillSize = 0 ifTrue:[^nil].
	].