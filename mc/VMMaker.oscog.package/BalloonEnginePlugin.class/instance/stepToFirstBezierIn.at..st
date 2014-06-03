beziers-simple
stepToFirstBezierIn: bezier at: yValue
	"Initialize the bezier at yValue.
	TODO: Check if reducing maxSteps from 2*deltaY to deltaY 
		brings a *significant* performance improvement.
		In theory this should make for double step performance
		but will cost in quality. Might be that the AA stuff will
		compensate for this - but I'm not really sure."
	| updateData deltaY maxSteps scaledStepSize squaredStepSize 
	startX startY viaX viaY endX endY 
	fwX1 fwX2 fwY1 fwY2 
	fwDx fwDDx fwDy fwDDy |
	<inline: false>
	<var: #updateData type:'int *'>


	"Do a quick check if there is anything at all to do"
	((self isWide: bezier) not and:[yValue >= (self bezierEndYOf: bezier)])
		ifTrue:[^self edgeNumLinesOf: bezier put: 0].

	"Now really initialize bezier"
	startX := self edgeXValueOf: bezier.
	startY := self edgeYValueOf: bezier.
	viaX := self bezierViaXOf: bezier.
	viaY := self bezierViaYOf: bezier.
	endX := self bezierEndXOf: bezier.
	endY := self bezierEndYOf: bezier.
	deltaY := endY - startY.

	"Initialize integer forward differencing"
	fwX1 := (viaX - startX) * 2.
	fwX2 := startX + endX - (viaX * 2).
	fwY1 := (viaY - startY) * 2.
	fwY2 := startY + endY - (viaY * 2).
	maxSteps := deltaY * 2.
	maxSteps < 2 ifTrue:[maxSteps := 2].
	scaledStepSize := 16r1000000 // maxSteps.
	squaredStepSize := self absoluteSquared8Dot24: scaledStepSize.
	fwDx := fwX1 * scaledStepSize.
	fwDDx := fwX2 * squaredStepSize * 2.
	fwDx := fwDx + (fwDDx // 2).
	fwDy := fwY1 * scaledStepSize.
	fwDDy := fwY2 * squaredStepSize * 2.
	fwDy := fwDy + (fwDDy // 2).

	"Store the values"
	self edgeNumLinesOf: bezier put: deltaY.

	updateData := self bezierUpdateDataOf: bezier.
	updateData at: GBUpdateX put: (startX * 256).
	updateData at: GBUpdateY put: (startY * 256).
	updateData at: GBUpdateDX put: fwDx.
	updateData at: GBUpdateDY put: fwDy.
	updateData at: GBUpdateDDX put: fwDDx.
	updateData at: GBUpdateDDY put: fwDDy.

	"And step to the first scan line"
	(startY := self edgeYValueOf: bezier) = yValue ifFalse:[
		self stepToNextBezierIn: bezier at: yValue.
		"Adjust number of lines remaining"
		self edgeNumLinesOf: bezier put: deltaY - (yValue - startY).
	].