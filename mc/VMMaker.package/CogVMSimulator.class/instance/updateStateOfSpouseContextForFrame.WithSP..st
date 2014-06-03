frame access
updateStateOfSpouseContextForFrame: theFP WithSP: theSP
	 "26431360 = (self frameContext: theFP) ifTrue:
		[self halt]."
	"((self stringOf: (self penultimateLiteralOf: (self frameMethodObject: theFP))) = #indexOf:startingAt:ifAbsent:) ifTrue:
		[self halt]."
	^super updateStateOfSpouseContextForFrame: theFP WithSP: theSP