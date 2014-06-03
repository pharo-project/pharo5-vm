fills-gradient
fillLinearGradientAA: fill ramp: ramp ds: deltaS dsX: dsX from: leftX to: rightX
	"This is the AA version of linear gradient filling."
	| colorMask colorShift baseShift rampIndex ds rampSize x idx rampValue 
	 aaLevel firstPixel lastPixel |
	<inline: false>
	<var: #ramp type:'int *'>

	aaLevel := self aaLevelGet.
	baseShift := self aaShiftGet.
	rampSize := self gradientRampLengthOf: fill.
	ds := deltaS.
	x := leftX.
	rampIndex := ds // 16r10000.

	firstPixel := self aaFirstPixelFrom: leftX to: rightX.
	lastPixel := self aaLastPixelFrom: leftX to: rightX.

	"Deal with the first n sub-pixels"
	colorMask := self aaColorMaskGet.
	colorShift := self aaColorShiftGet.
	[x < firstPixel and:[rampIndex < rampSize and:[rampIndex >= 0]]] whileTrue:[
		rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
		rampValue := (rampValue bitAnd: colorMask) >> colorShift.
		"Copy as many pixels as possible"
		[x < firstPixel and:[(ds//16r10000) = rampIndex]] whileTrue:[
			idx := x >> baseShift.
			spanBuffer at: idx put: (spanBuffer at: idx) + rampValue.
			x := x + 1.
			ds := ds + dsX].
		rampIndex := ds // 16r10000.
	].

	"Deal with the full pixels"
	colorMask := (self aaColorMaskGet >> self aaShiftGet) bitOr: 16rF0F0F0F0.
	colorShift := self aaShiftGet.
	[x < lastPixel and:[rampIndex < rampSize and:[rampIndex >= 0]]] whileTrue:[
		rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
		rampValue := (rampValue bitAnd: colorMask) >> colorShift.
		"Copy as many pixels as possible"
		[x < lastPixel and:[(ds//16r10000) = rampIndex]] whileTrue:[
			idx := x >> baseShift.
			spanBuffer at: idx put: (spanBuffer at: idx) + rampValue.
			x := x + aaLevel.
			ds := ds + (dsX << colorShift)].
		rampIndex := ds // 16r10000.
	].

	"Deal with the last n sub-pixels"
	colorMask := self aaColorMaskGet.
	colorShift := self aaColorShiftGet.
	[x < rightX and:[rampIndex < rampSize and:[rampIndex>=0]]] whileTrue:[
		rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
		rampValue := (rampValue bitAnd: colorMask) >> colorShift.
		"Copy as many pixels as possible"
		[x < rightX and:[(ds//16r10000) = rampIndex]] whileTrue:[
			idx := x >> baseShift.
			spanBuffer at: idx put: (spanBuffer at: idx) + rampValue.
			x := x + 1.
			ds := ds + dsX].
		rampIndex := ds // 16r10000.
	].
	^x