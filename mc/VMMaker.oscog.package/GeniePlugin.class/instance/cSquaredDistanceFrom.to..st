computation
cSquaredDistanceFrom: aPoint to: bPoint
	"arguments are pointer to ints paired as x,y coordinates of points"
	| aPointX aPointY bPointX bPointY xDiff yDiff |
	<var: #aPoint type: #'int *'>
	<var: #bPoint type: #'int *'>
	aPointX := aPoint at: 0.
	aPointY := aPoint at: 1.
	bPointX := bPoint at: 0.
	bPointY := bPoint at: 1.

	xDiff := bPointX - aPointX.
	yDiff := bPointY - aPointY.
	^ xDiff * xDiff + (yDiff * yDiff)