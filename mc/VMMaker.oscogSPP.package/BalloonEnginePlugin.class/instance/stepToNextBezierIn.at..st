beziers-simple
stepToNextBezierIn: bezier at: yValue
	"Incrementally step to the next scan line in the given bezier"
	|  xValue |
	<inline: true>
	xValue := self stepToNextBezierForward: (self bezierUpdateDataOf: bezier) at: yValue.
	self edgeXValueOf: bezier put: xValue.