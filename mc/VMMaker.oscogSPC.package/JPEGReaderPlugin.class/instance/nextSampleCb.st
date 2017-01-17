decoding
nextSampleCb
	| dx dy blockIndex sampleIndex sample curX sx sy |
	<inline: true>
	dx := curX := cbComponent at: CurrentXIndex.
	dy := cbComponent at: CurrentYIndex.
	sx := cbComponent at: HScaleIndex.
	sy := cbComponent at: VScaleIndex.
	(sx = 0 and:[sy = 0]) ifFalse:[
		dx := dx // sx.
		dy := dy // sy.
	].
	blockIndex := (dy bitShift: -3) * (cbComponent at: BlockWidthIndex) + (dx bitShift: -3).
	sampleIndex := ((dy bitAnd: 7) bitShift: 3) + (dx bitAnd: 7).
	sample := (cbBlocks at: blockIndex) at: sampleIndex.
	curX := curX + 1.
	curX < ((cbComponent at: MCUWidthIndex) * 8) ifTrue:[
		cbComponent at: CurrentXIndex put: curX.
	] ifFalse:[
		cbComponent at: CurrentXIndex put: 0.
		cbComponent at: CurrentYIndex put: (cbComponent at: CurrentYIndex) + 1.
	].
	^ sample