lines-simple
stepToNextLineIn: line at: yValue
	"Incrementally step to the next scan line in the given line"
	| x  err |
	<inline: true>
	x := (self edgeXValueOf: line) + (self lineXIncrementOf: line).
	err := (self lineErrorOf: line) + (self lineErrorAdjUpOf: line).
	err > 0 ifTrue:[
		x := x + (self lineXDirectionOf: line).
		err := err - (self lineErrorAdjDownOf: line).
	].
	self lineErrorOf: line put: err.
	self edgeXValueOf: line put: x.