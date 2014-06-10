debugging traps
externalDivorceFrame: theFP andContext: ctxt
	"((#(16r100570 16r101BC8) includes: theFP) or: [#(16r17159A4 16r1715948) includes: ctxt]) ifTrue:
		[self halt]."
	^super externalDivorceFrame: theFP andContext: ctxt