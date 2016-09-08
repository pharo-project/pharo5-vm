lines-wide
stepToNextWideLineIn: line at: yValue
	"Incrementally step to the next scan line in the given wide line"
	|  yEntry yExit lineWidth lineOffset lastX nextX |
	<inline: true>

	"Adjust entry/exit values"
	yEntry := (self wideLineEntryOf: line) + 1.
	yExit := (self wideLineExitOf: line) + 1.
	self wideLineEntryOf: line put: yEntry.
	self wideLineExitOf: line put: yExit.

	"Turn fills on/off"
	lineWidth := self wideLineExtentOf: line.
	lineOffset := self offsetFromWidth: lineWidth.
	yEntry >= lineOffset ifTrue:[self edgeFillsValidate: line].
	yExit >= 0 ifTrue:[self edgeFillsInvalidate: line].

	"Step to the next scan line"
	lastX := self edgeXValueOf: line.
	self stepToNextLineIn: line at: yValue.
	nextX := self edgeXValueOf: line.

	"Check for special start/end adjustments"
	(yEntry <= lineWidth or:[yExit+lineOffset >= 0]) ifTrue:[
		"Yes, need an update"
		self adjustWideLine: line afterSteppingFrom: lastX to: nextX.
	].