bezier-loading
subdivideToBeMonotonInY: index
	"Check if the given bezier curve is monoton in Y. If not, subdivide it"
	| startY viaY endY dy1 dy2 denom num |
	<inline: false>
	startY := self bzStartY: index.
	viaY := self bzViaY: index.
	endY := self bzEndY: index.

	dy1 := viaY - startY.
	dy2 := endY - viaY.
	(dy1 * dy2) >= 0 ifTrue:[^index]. "Bezier is monoton"

	self incrementStat: GWBezierMonotonSubdivisions by: 1.
	"Compute split value"
	denom := dy2 - dy1.
	num := dy1.
	num < 0 ifTrue:[num := 0 - num].
	denom < 0 ifTrue:[denom := 0 - denom].
	^self computeBezier: index splitAt: (num asFloat / denom asFloat).