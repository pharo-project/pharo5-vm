decoding
nextSampleY
	| dx dy blockIndex sampleIndex sample curX sx sy |
	<inline: true>
	dx := curX := yComponent at: CurrentXIndex.
	dy := yComponent at: CurrentYIndex.
	sx := yComponent at: HScaleIndex.
	sy := yComponent at: VScaleIndex.
	(sx = 0 and:[sy = 0]) ifFalse:[
		dx := dx // sx.
		dy := dy // sy.
	].
	blockIndex := (dy bitShift: -3) * (yComponent at: BlockWidthIndex) + (dx bitShift: -3).
	sampleIndex := ((dy bitAnd: 7) bitShift: 3) + (dx bitAnd: 7).
	sample := (yBlocks at: blockIndex) at: sampleIndex.
	curX := curX + 1.
	curX < ((yComponent at: MCUWidthIndex) * 8) ifTrue:[
		yComponent at: CurrentXIndex put: curX.
	] ifFalse:[
		yComponent at: CurrentXIndex put: 0.
		yComponent at: CurrentYIndex put: (yComponent at: CurrentYIndex) + 1.
	].
	^ sample