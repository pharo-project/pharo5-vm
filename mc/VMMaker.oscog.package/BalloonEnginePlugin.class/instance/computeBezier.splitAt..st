bezier-loading
computeBezier: index splitAt: param
	"Split the bezier curve at the given parametric value.
	Note: Since this method is only invoked to make non-monoton
		beziers monoton we must check for the resulting y values
		to be *really* between the start and end value."
	| startX startY viaX viaY endX endY newIndex 
	leftViaX  leftViaY rightViaX rightViaY sharedX sharedY |
	<inline: false>
	<var: #param type:'double '>
	leftViaX := startX := self bzStartX: index.
	leftViaY := startY := self bzStartY: index.
	rightViaX := viaX := self bzViaX: index.
	rightViaY := viaY := self bzViaY: index.
	endX := self bzEndX: index.
	endY := self bzEndY: index.

	"Compute intermediate points"
	sharedX := leftViaX := leftViaX + ((viaX - startX) asFloat * param) asInteger.
	sharedY := leftViaY := leftViaY + ((viaY - startY) asFloat * param) asInteger.
	rightViaX := rightViaX + ((endX - viaX) asFloat * param) asInteger.
	rightViaY := rightViaY + ((endY - viaY) asFloat * param) asInteger.
	"Compute new shared point"
	sharedX := sharedX + ((rightViaX - leftViaX) asFloat * param) asInteger.
	sharedY := sharedY + ((rightViaY - leftViaY) asFloat * param) asInteger.

	"Check the new via points"
	leftViaY := self assureValue: leftViaY between: startY and: sharedY.
	rightViaY := self assureValue: rightViaY between: sharedY and: endY.

	newIndex := self allocateBezierStackEntry.
	engineStopped ifTrue:[^0]. "Something went wrong"

	"Store the first part back"
	self bzViaX: index put: leftViaX.
	self bzViaY: index put: leftViaY.
	self bzEndX: index put: sharedX.
	self bzEndY: index put: sharedY.
	"Store the second point back"
	self bzStartX: newIndex put: sharedX.
	self bzStartY: newIndex put: sharedY.
	self bzViaX: newIndex put: rightViaX.
	self bzViaY: newIndex put: rightViaY.
	self bzEndX: newIndex put: endX.
	self bzEndY: newIndex put: endY.

	^newIndex