transforming
transformPoints: n
	"Transform n (n=1,2,3) points.
	If haveMatrix is true then the matrix contains the actual transformation."
	<inline: true>
	n > 0 ifTrue:[self transformPoint: self point1Get].
	n > 1 ifTrue:[self transformPoint: self point2Get].
	n > 2 ifTrue:[self transformPoint: self point3Get].
	n > 3 ifTrue:[self transformPoint: self point4Get].