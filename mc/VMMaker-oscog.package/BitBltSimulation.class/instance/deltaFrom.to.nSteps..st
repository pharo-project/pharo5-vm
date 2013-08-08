pixel mapping
deltaFrom: x1 to: x2 nSteps: n
	"Utility routine for computing Warp increments."
	<inline: true>
	x2 > x1
		ifTrue: [^ x2 - x1 + FixedPt1 // (n+1) + 1]
		ifFalse: [x2 = x1 ifTrue: [^ 0].
				^ 0 - (x1 - x2 + FixedPt1 // (n+1) + 1)]