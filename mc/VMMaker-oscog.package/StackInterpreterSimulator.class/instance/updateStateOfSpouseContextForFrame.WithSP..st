debugging traps
updateStateOfSpouseContextForFrame: theFP WithSP: theSP
	"(self frameContext: theFP) = 22163268 ifTrue:
		[self halt]."
	^super updateStateOfSpouseContextForFrame: theFP WithSP: theSP