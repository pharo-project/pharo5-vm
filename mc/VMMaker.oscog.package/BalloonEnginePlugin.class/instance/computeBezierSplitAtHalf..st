bezier-loading
computeBezierSplitAtHalf: index
	"Split the bezier curve at 0.5."
	| startX startY viaX viaY endX endY newIndex 
	leftViaX  leftViaY rightViaX rightViaY sharedX sharedY |
	<inline: false>

	newIndex := self allocateBezierStackEntry.
	engineStopped ifTrue:[^0]. "Something went wrong"

	leftViaX := startX := self bzStartX: index.
	leftViaY := startY := self bzStartY: index.
	rightViaX := viaX := self bzViaX: index.
	rightViaY := viaY := self bzViaY: index.
	endX := self bzEndX: index.
	endY := self bzEndY: index.
	"Compute intermediate points"
	leftViaX := leftViaX + ((viaX - startX) // 2).
	leftViaY := leftViaY + ((viaY - startY) // 2).
	sharedX := rightViaX := rightViaX + ((endX - viaX) // 2).
	sharedY := rightViaY := rightViaY + ((endY - viaY) // 2).
	"Compute new shared point"
	sharedX := sharedX + ((leftViaX - rightViaX) // 2).
	sharedY := sharedY + ((leftViaY - rightViaY) // 2).
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