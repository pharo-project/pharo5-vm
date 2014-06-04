displaying
fillColorSpan: pixelValue32 from: leftX to: rightX
	"Fill the span buffer between leftEdge and rightEdge with the given pixel value."
	| x0 x1 |
	<inline: true>
	"Use a unrolled version for anti-aliased fills..."
	self aaLevelGet = 1
		ifFalse:[^self fillColorSpanAA: pixelValue32 x0: leftX x1: rightX].
	x0 := leftX.
	x1 := rightX.
	"Unroll the inner loop four times, since we're only storing data."
	[x0 + 4 < x1] whileTrue:[
		spanBuffer at: x0 put: pixelValue32.
		spanBuffer at: x0+1 put: pixelValue32.
		spanBuffer at: x0+2 put: pixelValue32.
		spanBuffer at: x0+3 put: pixelValue32.
		x0 := x0+4.
	].
	[x0 < x1] whileTrue:[
		spanBuffer at: x0 put: pixelValue32.
		x0 := x0 + 1.
	].