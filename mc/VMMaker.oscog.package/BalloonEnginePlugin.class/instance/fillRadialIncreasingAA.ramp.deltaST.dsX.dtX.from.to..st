fills-gradient
fillRadialIncreasingAA: fill ramp: ramp deltaST: deltaST dsX: dsX dtX: dtX from: leftX to: rightX
	"Part 2b) Compute the increasing part of the ramp"
	| ds dt rampIndex rampValue length2 x nextLength rampSize lastLength 
	aaLevel colorMask colorShift baseShift index firstPixel lastPixel |
	<inline: false>
	<var: #ramp type:'int *'>
	<var: #deltaST type:' int *'>

	ds := (self cCoerce: deltaST to:'int*') at: 0.
	dt := (self cCoerce: deltaST to:'int*') at: 1.
	aaLevel := self aaLevelGet.
	baseShift := self aaShiftGet.
	rampIndex := self accurateLengthOf: ds // 16r10000 with: dt // 16r10000.
	rampSize := self gradientRampLengthOf: fill.
	length2 := (rampSize-1) * (rampSize-1). "This is the upper bound"
	nextLength := (rampIndex+1) * (rampIndex+1).
	lastLength := self squaredLengthOf: ds //  16r10000 with: dt // 16r10000.

	x := leftX.

	firstPixel := self aaFirstPixelFrom: leftX to: rightX.
	lastPixel := self aaLastPixelFrom: leftX to: rightX.

	"Deal with the first n subPixels"
	(x < firstPixel and:[lastLength < length2]) ifTrue:[
		colorMask := self aaColorMaskGet.
		colorShift := self aaColorShiftGet.
		rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
		rampValue := (rampValue bitAnd: colorMask) >> colorShift.
		[x < firstPixel and:[lastLength < length2]] whileTrue:[
			"Try to copy the current value more than once"
			[x < firstPixel and:[(self squaredLengthOf: ds //  16r10000 with: dt // 16r10000) <= nextLength]]
				whileTrue:[	index := x >> baseShift.
							spanBuffer at: index put: (spanBuffer at: index) + rampValue.
							x := x + 1.
							ds := ds + dsX.
							dt := dt + dtX].
			lastLength := self squaredLengthOf: ds //  16r10000 with: dt // 16r10000.
			[lastLength > nextLength] whileTrue:[
				rampIndex := rampIndex + 1.
				rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
				rampValue := (rampValue bitAnd: colorMask) >> colorShift.
				nextLength := (rampIndex+1) * (rampIndex+1).
			].
		].
	].

	"Deal with the full pixels"
	(x < lastPixel and:[lastLength < length2]) ifTrue:[
		colorMask := (self aaColorMaskGet >> self aaShiftGet) bitOr: 16rF0F0F0F0.
		colorShift := self aaShiftGet.
		rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
		rampValue := (rampValue bitAnd: colorMask) >> colorShift.
		[x < lastPixel and:[lastLength < length2]] whileTrue:[
			"Try to copy the current value more than once"
			[x < lastPixel and:[(self squaredLengthOf: ds //  16r10000 with: dt // 16r10000) <= nextLength]]
				whileTrue:[	index := x >> baseShift.
							spanBuffer at: index put: (spanBuffer at: index) + rampValue.
							x := x + aaLevel.
							ds := ds + (dsX << colorShift).
							dt := dt + (dtX << colorShift)].
			lastLength := self squaredLengthOf: ds //  16r10000 with: dt // 16r10000.
			[lastLength > nextLength] whileTrue:[
				rampIndex := rampIndex + 1.
				rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
				rampValue := (rampValue bitAnd: colorMask) >> colorShift.
				nextLength := (rampIndex+1) * (rampIndex+1).
			].
		].
	].

	"Deal with last n sub-pixels"
	(x < rightX and:[lastLength < length2]) ifTrue:[
		colorMask := self aaColorMaskGet.
		colorShift := self aaColorShiftGet.
		rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
		rampValue := (rampValue bitAnd: colorMask) >> colorShift.
		[x < rightX and:[lastLength < length2]] whileTrue:[
			"Try to copy the current value more than once"
			[x < rightX and:[(self squaredLengthOf: ds //  16r10000 with: dt // 16r10000) <= nextLength]]
				whileTrue:[	index := x >> baseShift.
							spanBuffer at: index put: (spanBuffer at: index) + rampValue.
							x := x + 1.
							ds := ds + dsX.
							dt := dt + dtX].
			lastLength := self squaredLengthOf: ds //  16r10000 with: dt // 16r10000.
			[lastLength > nextLength] whileTrue:[
				rampIndex := rampIndex + 1.
				rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
				rampValue := (rampValue bitAnd: colorMask) >> colorShift.
				nextLength := (rampIndex+1) * (rampIndex+1).
			].
		].
	].
	"Done -- store stuff back"
	(self cCoerce: deltaST to: 'int *') at: 0 put: ds.
	(self cCoerce: deltaST to: 'int *') at: 1 put: dt.
	^x