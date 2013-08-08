lines-wide
stepToFirstWideLineIn: line at: yValue
	"Initialize the wide line at yValue."
	| startY yEntry yExit lineWidth nLines lineOffset startX xDir |
	<inline: false>

	"Get some values"
	lineWidth := self wideLineExtentOf: line.
	lineOffset := self offsetFromWidth: lineWidth.

	"Compute the incremental values of the line"
	startX := self edgeXValueOf: line.
	startY := self edgeYValueOf: line.
	self stepToFirstLineIn: line at: startY.
	nLines := (self edgeNumLinesOf: line).
	xDir := self lineXDirectionOf: line.

	"Adjust the line to start at the correct X position"
	self edgeXValueOf: line put: startX - lineOffset.

	"Adjust the number of lines to include the lineWidth"
	self edgeNumLinesOf: line put: nLines + lineWidth.

	"Adjust the values for x-major lines"
	xDir > 0 ifTrue:[
		self wideLineWidthOf: line put: (self lineXIncrementOf: line) + lineWidth.
	] ifFalse:[
		self wideLineWidthOf: line put: lineWidth - (self lineXIncrementOf: line). "adding"
		self edgeXValueOf: line put: (self edgeXValueOf: line) + (self lineXIncrementOf: line).
	].

	"Compute the points where we have to turn on/off the fills"
	yEntry := 0.						"turned on at lineOffset"
	yExit := 0 - nLines - lineOffset.	"turned off at zero"
	self wideLineEntryOf: line put: yEntry.
	self wideLineExitOf: line put: yExit.

	"Turn the fills on/off as necessary"
	(yEntry >= lineOffset and:[yExit < 0])
		ifTrue:[self edgeFillsValidate: line]
		ifFalse:[self edgeFillsInvalidate: line].

	"And step to the first scan line"
	startY = yValue ifFalse:[
		startY to: yValue-1 do:[:i| self stepToNextWideLineIn: line at: i].
		"Adjust number of lines remaining"
		self edgeNumLinesOf: line put: (self edgeNumLinesOf: line) - (yValue - startY).
	].
