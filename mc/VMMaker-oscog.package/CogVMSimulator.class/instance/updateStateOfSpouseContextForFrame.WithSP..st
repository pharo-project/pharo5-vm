frame access
updateStateOfSpouseContextForFrame: theFP WithSP: theSP
	 "26431360 = (self frameContext: theFP) ifTrue:
		[self halt]."
	^super updateStateOfSpouseContextForFrame: theFP WithSP: theSP