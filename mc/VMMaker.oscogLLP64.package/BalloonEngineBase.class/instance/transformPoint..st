transforming
transformPoint: point
	"Transform the given point. If haveMatrix is true then use the current transformation."
	<var:#point type:'int *'>
	self hasEdgeTransform ifFalse:[
		"Multiply each component by aaLevel and add a half pixel"
		point at: 0 put: (point at: 0) + self destOffsetXGet * self aaLevelGet.
		point at: 1 put: (point at: 1) + self destOffsetYGet * self aaLevelGet.
	] ifTrue:[
		"Note: AA adjustment is done in #transformPoint: for higher accuracy"
		self transformPoint: point into: point.
	].