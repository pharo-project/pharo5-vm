bezier-loading
subdivideToBeMonotonInX: index
	"Check if the given bezier curve is monoton in X. If not, subdivide it"
	| denom num startX viaX endX dx1 dx2 |
	<inline: false>
	startX := self bzStartX: index.
	viaX := self bzViaX: index.
	endX := self bzEndX: index.

	dx1 := viaX - startX.
	dx2 := endX - viaX.
	(dx1 * dx2) >= 0 ifTrue:[^index]. "Bezier is monoton"

	self incrementStat: GWBezierMonotonSubdivisions by: 1.
	"Compute split value"
	denom := dx2 - dx1.
	num := dx1.
	num < 0 ifTrue:[num := 0 - num].
	denom < 0 ifTrue:[denom := 0 - denom].
	^self computeBezier: index splitAt: (num asFloat / denom asFloat).