bezier-loading
subdivideBezier: index
	"Subdivide the given bezier curve if necessary"
	| startX startY endX endY deltaX deltaY |
	<inline: false>
	startY := self bzStartY: index.
	endY := self bzEndY: index.

	"If the receiver is horizontal, don't do anything"
	(endY = startY) ifTrue:[^index].

	"TODO: If the curve can be represented as a line, then do so"

	"If the height of the curve exceeds 256 pixels, subdivide 
	(forward differencing is numerically not very stable)"
	deltaY := endY - startY.
	deltaY < 0 ifTrue:[deltaY := 0 - deltaY].
	(deltaY > 255) ifTrue:[
		self incrementStat: GWBezierHeightSubdivisions by: 1.
		^self computeBezierSplitAtHalf: index].

	"Check if the incremental values could possibly overflow the scaled integer range"
	startX := self bzStartX: index.
	endX := self bzEndX: index.
	deltaX := endX - startX.
	deltaX < 0 ifTrue:[deltaX := 0 - deltaX].
	deltaY * 32 < deltaX ifTrue:[
		self incrementStat: GWBezierOverflowSubdivisions by: 1.
		^self computeBezierSplitAtHalf: index].
	^index
