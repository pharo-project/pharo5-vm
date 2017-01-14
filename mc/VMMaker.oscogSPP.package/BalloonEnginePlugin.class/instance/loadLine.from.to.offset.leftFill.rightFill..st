lines-loading
loadLine: line from: point1 to: point2 offset: yOffset leftFill: leftFill rightFill: rightFill
	"Load the line defined by point1 and point2."
	| p1 p2 yDir |
	<var: #point1 type:'int *'>
	<var: #point2 type:'int *'>
	<var: #p1 type:'int *'>
	<var: #p2 type:'int *'>

	(point1 at: 1) <= (point2 at: 1) 
		ifTrue:[	p1 := point1.
				p2 := point2.
				yDir := 1]
		ifFalse:[	p1 := point2.
				p2 := point1.
				yDir := -1].
	self edgeXValueOf: line put: (p1 at: 0).
	self edgeYValueOf: line put: (p1 at: 1) - yOffset.
	self edgeZValueOf: line put: self currentZGet.
	self edgeLeftFillOf: line put: leftFill.
	self edgeRightFillOf: line put: rightFill.
	self lineEndXOf: line put: (p2 at: 0).
	self lineEndYOf: line put: (p2 at: 1) - yOffset.
	self lineYDirectionOf: line put: yDir.