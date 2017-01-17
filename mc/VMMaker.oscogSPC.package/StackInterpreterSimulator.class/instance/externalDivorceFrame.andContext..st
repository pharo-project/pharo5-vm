debugging traps
externalDivorceFrame: theFP andContext: ctxt
	"(theFP = -208 or: [ctxt = 22189568]) ifTrue:
		[self halt]."
	^super externalDivorceFrame: theFP andContext: ctxt