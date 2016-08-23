setup
performCopyLoop
	"Based on the values provided during setup choose and
	perform the appropriate inner loop function."
	<inline: true> "Should be inlined into caller for speed"
	self destMaskAndPointerInit.
	noSource ifTrue: ["Simple fill loop"
		self copyLoopNoSource.
	] ifFalse: ["Loop using source and dest"
		self checkSourceOverlap.
		(sourceDepth ~= destDepth or: [(cmFlags ~= 0) or:[sourceMSB ~= destMSB]]) ifTrue: [
			"If we must convert between pixel depths or use
			color lookups or swap pixels use the general version"
			self copyLoopPixMap.
		] ifFalse: [
			"Otherwise we simple copy pixels and can use a faster version"
			self sourceSkewAndPointerInit.
			self copyLoop.
		]
	].