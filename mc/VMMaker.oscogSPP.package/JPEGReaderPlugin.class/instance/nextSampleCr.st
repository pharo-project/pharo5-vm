decoding
nextSampleCr
	| dx dy blockIndex sampleIndex sample curX sx sy |
	<inline: true>
	dx := curX := crComponent at: CurrentXIndex.
	dy := crComponent at: CurrentYIndex.
	sx := crComponent at: HScaleIndex.
	sy := crComponent at: VScaleIndex.
	(sx = 0 and:[sy = 0]) ifFalse:[
		dx := dx // sx.
		dy := dy // sy.
	].
	blockIndex := (dy bitShift: -3) * (crComponent at: BlockWidthIndex) + (dx bitShift: -3).
	sampleIndex := ((dy bitAnd: 7) bitShift: 3) + (dx bitAnd: 7).
	sample := (crBlocks at: blockIndex) at: sampleIndex.
	curX := curX + 1.
	curX < ((crComponent at: MCUWidthIndex) * 8) ifTrue:[
		crComponent at: CurrentXIndex put: curX.
	] ifFalse:[
		crComponent at: CurrentXIndex put: 0.
		crComponent at: CurrentYIndex put: (crComponent at: CurrentYIndex) + 1.
	].
	^ sample