beziers-wide
stepToFirstWideBezierIn: bezier at: yValue
	"Initialize the bezier at yValue"	
	| lineWidth startY nLines yEntry yExit lineOffset endX xDir |
	<inline: false>

	"Get some values"
	lineWidth := self wideBezierExtentOf: bezier.
	lineOffset := self offsetFromWidth: lineWidth.

	"Compute the incremental values of the bezier"
	endX := self bezierEndXOf: bezier.
	startY := self edgeYValueOf: bezier.
	self stepToFirstBezierIn: bezier at: startY.
	nLines := (self edgeNumLinesOf: bezier).

	"Copy the incremental update data"
	0 to: 5 do:[:i|
		(self wideBezierUpdateDataOf: bezier) at: i put:
			((self bezierUpdateDataOf: bezier) at: i).
	].

	"Compute primary x direction of curve (e.g., 1: left to right; -1: right to left)."
	xDir := ((self bezierUpdateDataOf: bezier) at: GBUpdateDX).
	xDir = 0 ifTrue:[((self bezierUpdateDataOf: bezier) at: GBUpdateDDX)].
	xDir >= 0 ifTrue:[xDir := 1] ifFalse:[xDir := -1].

	"Adjust the curve to start/end at the right position"
	xDir < 0
		ifTrue:[self adjustWideBezierLeft: bezier width: lineWidth offset: lineOffset endX: endX]
		ifFalse:[self adjustWideBezierRight: bezier width: lineWidth offset: lineOffset endX: endX].

	"Adjust the last value for horizontal lines"
	nLines = 0 ifTrue:[(self bezierUpdateDataOf: bezier) at: GBUpdateX put: 
						(self bezierFinalXOf: bezier) * 256].
	"Adjust the number of lines to include the lineWidth"
	self edgeNumLinesOf: bezier put: nLines + lineWidth.

	"Compute the points where we have to turn on/off the fills"
	yEntry := 0.						"turned on at lineOffset"
	yExit := 0 - nLines - lineOffset.	"turned off at zero"
	self wideBezierEntryOf: bezier put: yEntry.
	self wideBezierExitOf: bezier put: yExit.

	"Turn the fills on/off as necessary"
	(yEntry >= lineOffset and:[yExit < 0])
		ifTrue:[self edgeFillsValidate: bezier]
		ifFalse:[self edgeFillsInvalidate: bezier].

	self computeFinalWideBezierValues: bezier width: lineWidth.

	"And step to the first scan line"
	startY = yValue ifFalse:[
		"Note: Must single step here so that entry/exit works"
		startY to: yValue-1 do:[:i| self stepToNextWideBezierIn: bezier at: i].
		"Adjust number of lines remaining"
		self edgeNumLinesOf: bezier put: (self edgeNumLinesOf: bezier) - (yValue - startY).
	].