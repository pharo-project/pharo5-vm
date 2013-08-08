displaying
drawWideEdge: edge from: leftX
	"Draw the given edge starting from leftX with the edge's fill.
	Return the end value of the drawing operation."
	| rightX fill type lineWidth |
	<inline: false> "Not for the moment"
	type := self edgeTypeOf: edge.
	dispatchedValue := edge.
	self dispatchOn: type in: WideLineWidthTable.
	lineWidth := dispatchReturnValue.
	self dispatchOn: type in: WideLineFillTable.
	fill := self makeUnsignedFrom: dispatchReturnValue.
	fill = 0 ifTrue:[^leftX].
	"Check if this line is only partially visible"
	"self assert:(self isFillColor: fill)."
	rightX := leftX + lineWidth.
	self fillSpan: fill from: leftX to: rightX.
	^rightX