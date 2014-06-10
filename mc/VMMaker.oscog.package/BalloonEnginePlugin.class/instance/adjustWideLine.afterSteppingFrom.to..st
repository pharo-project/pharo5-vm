lines-wide
adjustWideLine: line afterSteppingFrom: lastX to: nextX
	"Adjust the wide line after it has been stepped from lastX to nextX.
	Special adjustments of line width and start position are made here
	to simulate a rectangular brush"
	|  yEntry yExit lineWidth lineOffset deltaX xDir baseWidth |
	<inline: false>	"Don't inline this"


	"Fetch the values the adjustment decisions are based on"
	yEntry := (self wideLineEntryOf: line).
	yExit := (self wideLineExitOf: line).
	baseWidth := self wideLineExtentOf: line.
	lineOffset := self offsetFromWidth: baseWidth.
	lineWidth := self wideLineWidthOf: line.
	xDir := self lineXDirectionOf: line.
	deltaX := nextX - lastX.

	"Adjust the start of the line to fill an entire rectangle"
	yEntry < baseWidth ifTrue:[
		xDir < 0
			ifTrue:[	lineWidth := lineWidth - deltaX] "effectively adding"
			ifFalse:[	lineWidth := lineWidth + deltaX.
					self edgeXValueOf: line put: lastX].
	].

	"Adjust the end of x-major lines"
	((yExit + lineOffset) = 0) ifTrue:[
		xDir > 0
			ifTrue:[lineWidth := lineWidth - (self lineXIncrementOf: line)]
			ifFalse:[lineWidth := lineWidth + (self lineXIncrementOf: line).	"effectively subtracting"
					self edgeXValueOf: line put: lastX].
	].

	"Adjust the end of the line to fill an entire rectangle"
	(yExit + lineOffset) > 0 ifTrue:[
		xDir < 0
			ifTrue:[	lineWidth := lineWidth + deltaX. "effectively subtracting"
					self edgeXValueOf: line put: lastX]
			ifFalse:[	lineWidth := lineWidth - deltaX]
	].

	"Store the manipulated line width back"
	self wideLineWidthOf: line put: lineWidth.