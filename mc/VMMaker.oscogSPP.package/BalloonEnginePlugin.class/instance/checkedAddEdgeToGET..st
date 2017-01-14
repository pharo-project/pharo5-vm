GET processing
checkedAddEdgeToGET: edge
	"Add the edge to the global edge table.
	For known edge types, check if the edge intersects the visible region"
	<inline: true>

	(self isLine: edge) ifTrue:[^self checkedAddLineToGET: edge].
	(self isBezier: edge) ifTrue:[^self checkedAddBezierToGET: edge].
	self addEdgeToGET: edge.
