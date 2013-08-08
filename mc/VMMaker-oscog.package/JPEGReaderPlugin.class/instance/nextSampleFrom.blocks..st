decoding
nextSampleFrom: aComponent blocks: aBlockArray
	| dx dy blockIndex sampleIndex sample curX sx sy |
	<var: #aComponent type: 'int *'>
	<var: #aBlockArray type: 'int **'>
	<inline: true>
	dx := curX := aComponent at: CurrentXIndex.
	dy := aComponent at: CurrentYIndex.
	sx := aComponent at: HScaleIndex.
	sy := aComponent at: VScaleIndex.
	(sx = 0 and:[sy = 0]) ifFalse:[
		dx := dx // sx.
		dy := dy // sy.
	].
	blockIndex := (dy bitShift: -3) * (aComponent at: BlockWidthIndex) + (dx bitShift: -3).
	sampleIndex := ((dy bitAnd: 7) bitShift: 3) + (dx bitAnd: 7).
	sample := (aBlockArray at: blockIndex) at: sampleIndex.
	curX := curX + 1.
	curX < ((aComponent at: MCUWidthIndex) * 8) ifTrue:[
		aComponent at: CurrentXIndex put: curX.
	] ifFalse:[
		aComponent at: CurrentXIndex put: 0.
		aComponent at: CurrentYIndex put: (aComponent at: CurrentYIndex) + 1.
	].
	^ sample