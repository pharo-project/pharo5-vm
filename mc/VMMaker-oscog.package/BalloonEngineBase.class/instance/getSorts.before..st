GET processing
getSorts: edge1 before: edge2
	"Return true if the edge at index i should sort before the edge at index j."
	| diff |
	<inline: false>
	edge1 = edge2 ifTrue:[^true].
	"First, sort by Y"
	diff := (self edgeYValueOf: edge1) - (self edgeYValueOf: edge2).
	diff = 0 ifFalse:[^diff < 0].
	"Then, by X"
	diff := (self edgeXValueOf: edge1) - (self edgeXValueOf: edge2).
	^diff < 0