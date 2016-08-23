setup
copyBitsFrom: startX to: stopX at: yValue
	"Support for the balloon engine."
	<export: true>
	destX := startX.
	destY := yValue.
	sourceX := startX.
	width := (stopX - startX).
	self copyBits.
	self showDisplayBits.