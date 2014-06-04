beziers-simple
stepToNextBezierForward: updateData at: yValue
	"Incrementally step to the next scan line in the given bezier update data.
	Note: This method has been written so that inlining works, e.g.,
		not declaring updateData as 'int*' but casting it on every use."
	| minY lastX lastY fwDx fwDy |
	<inline: true>
	lastX := (self cCoerce: updateData to: 'int*') at: GBUpdateX.
	lastY := (self cCoerce: updateData to: 'int*') at: GBUpdateY.
	fwDx := (self cCoerce: updateData to: 'int*') at: GBUpdateDX.
	fwDy := (self cCoerce: updateData to: 'int*') at: GBUpdateDY.
	minY := yValue * 256.
	"Step as long as we haven't yet reached minY and also
	as long as fwDy is greater than zero thus stepping down.
	Note: The test for fwDy should not be necessary in theory
		but is a good insurance in practice."
	[minY > lastY and:[fwDy >= 0]] whileTrue:[
		lastX := lastX + ((fwDx + 16r8000) // 16r10000).
		lastY := lastY + ((fwDy + 16r8000) // 16r10000).
		fwDx := fwDx + ((self cCoerce: updateData to: 'int*') at: GBUpdateDDX).
		fwDy := fwDy + ((self cCoerce: updateData to: 'int*') at: GBUpdateDDY).
	].
	(self cCoerce: updateData to: 'int*') at: GBUpdateX put: lastX.
	(self cCoerce: updateData to: 'int*') at: GBUpdateY put: lastY.
	(self cCoerce: updateData to: 'int*') at: GBUpdateDX put: fwDx.
	(self cCoerce: updateData to: 'int*') at: GBUpdateDY put: fwDy.
	^lastX // 256
