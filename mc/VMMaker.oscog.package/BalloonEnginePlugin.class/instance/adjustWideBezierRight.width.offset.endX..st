beziers-wide
adjustWideBezierRight: bezier width: lineWidth offset: lineOffset endX: endX
	"Adjust the wide bezier curve (dx >= 0) to start/end at the right point"
	| lastX lastY |
	<inline: false>
	(self bezierUpdateDataOf: bezier) at: GBUpdateX put: 
		(((self bezierUpdateDataOf: bezier) at: GBUpdateX) + (lineOffset * 256)).
	"Set the lastX/Y value of the second curve lineWidth pixels right/down"
	"Set lineWidth-lineOffset pixels left"
	lastX := (self wideBezierUpdateDataOf: bezier) at: GBUpdateX.
	(self wideBezierUpdateDataOf: bezier) at: GBUpdateX put: lastX - (lineWidth - lineOffset * 256).
	lastY := (self wideBezierUpdateDataOf: bezier) at: GBUpdateY.
	"Set lineWidth pixels down"
	(self wideBezierUpdateDataOf: bezier) at: GBUpdateY put: lastY + (lineWidth * 256).
	"Record the last X value"
	self bezierFinalXOf: bezier put: endX - lineOffset + lineWidth.