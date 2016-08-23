beziers-wide
stepToNextWideBezierIn: bezier at: yValue
	"Incrementally step to the next scan line in the given wide bezier"
	|  yEntry yExit lineWidth lineOffset |
	<inline: false>	"Don't inline this"

	lineWidth := self wideBezierExtentOf: bezier.
	lineOffset := self offsetFromWidth: lineWidth.

	yEntry := (self wideBezierEntryOf: bezier) + 1.
	yExit := (self wideBezierExitOf: bezier) + 1.
	self wideBezierEntryOf: bezier put: yEntry.
	self wideBezierExitOf: bezier put: yExit.
	yEntry >= lineOffset ifTrue:[self edgeFillsValidate: bezier].
	yExit >= 0 ifTrue:[self edgeFillsInvalidate: bezier].

	"Check if we have to step the upper curve"
	(yExit + lineOffset < 0) ifTrue:[
		self stepToNextBezierForward: (self bezierUpdateDataOf: bezier) at: yValue.
	] ifFalse:[
		"Adjust the last x value to the final x recorded previously"
		(self bezierUpdateDataOf: bezier) at: GBUpdateX put: (self bezierFinalXOf: bezier) * 256.
	].
	"Step the lower curve"
	self stepToNextBezierForward: (self wideBezierUpdateDataOf: bezier) at: yValue.

	self computeFinalWideBezierValues: bezier width: lineWidth.