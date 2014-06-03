fills-gradient
fillRadialDecreasingAA: fill ramp: ramp deltaST: deltaST dsX: dsX dtX: dtX from: leftX to: rightX
	"Part 2a) Compute the decreasing part of the ramp"
	| ds dt rampIndex rampValue length2 x nextLength x1
	aaLevel colorMask colorShift baseShift index firstPixel lastPixel |
	<inline: false>
	<var: #ramp type:'int *'>
	<var: #deltaST type:' int *'>

	ds := (self cCoerce: deltaST to:'int*') at: 0.
	dt := (self cCoerce: deltaST to:'int*') at: 1.
	aaLevel := self aaLevelGet.
	baseShift := self aaShiftGet.
	rampIndex := self accurateLengthOf: ds // 16r10000 with: dt // 16r10000.
	length2 := (rampIndex-1) * (rampIndex-1).

	x := leftX.
	x1 := self fillOriginXOf: fill.
	x1 > rightX ifTrue:[x1 := rightX].
	firstPixel := self aaFirstPixelFrom: leftX to: x1.
	lastPixel := self aaLastPixelFrom: leftX to: x1.

	"Deal with the first n sub-pixels"
	(x < firstPixel) ifTrue:[
		colorMask := self aaColorMaskGet.
		colorShift := self aaColorShiftGet.
		rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
		rampValue := (rampValue bitAnd: colorMask) >> colorShift.
		[x < firstPixel] whileTrue:[
			"Try to copy the current value more than just once"
			[x < firstPixel and:[(self squaredLengthOf: ds //  16r10000 with: dt // 16r10000) >= length2]]
				whileTrue:[	index := x >> baseShift.
							spanBuffer at: index put: (spanBuffer at: index) + rampValue.
							x := x + 1.
							ds := ds + dsX.
							dt := dt + dtX].
			"Step to next ramp value"
			nextLength := self squaredLengthOf: ds //  16r10000 with: dt // 16r10000.
			[nextLength < length2] whileTrue:[
				rampIndex := rampIndex - 1.
				rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
				rampValue := (rampValue bitAnd: colorMask) >> colorShift.
				length2 := (rampIndex-1) * (rampIndex-1).
			].
		].
	].

	"Deal with the full pixels"
	(x < lastPixel) ifTrue:[
		colorMask := (self aaColorMaskGet >> self aaShiftGet) bitOr: 16rF0F0F0F0.
		colorShift := self aaShiftGet.
		rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
		rampValue := (rampValue bitAnd: colorMask) >> colorShift.
		[x < lastPixel] whileTrue:[
			"Try to copy the current value more than just once"
			[x < lastPixel and:[(self squaredLengthOf: ds //  16r10000 with: dt // 16r10000) >= length2]]
				whileTrue:[	index := x >> baseShift.
							spanBuffer at: index put: (spanBuffer at: index) + rampValue.
							x := x + aaLevel.
							ds := ds + (dsX << colorShift).
							dt := dt + (dtX << colorShift)].
			"Step to next ramp value"
			nextLength := self squaredLengthOf: ds //  16r10000 with: dt // 16r10000.
			[nextLength < length2] whileTrue:[
				rampIndex := rampIndex - 1.
				rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
				rampValue := (rampValue bitAnd: colorMask) >> colorShift.
				length2 := (rampIndex-1) * (rampIndex-1).
			].
		].
	].

	"Deal with the last n sub-pixels"
	(x < x1) ifTrue:[
		colorMask := self aaColorMaskGet.
		colorShift := self aaColorShiftGet.
		rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
		rampValue := (rampValue bitAnd: colorMask) >> colorShift.
		[x < x1] whileTrue:[
			"Try to copy the current value more than just once"
			[x < x1 and:[(self squaredLengthOf: ds //  16r10000 with: dt // 16r10000) >= length2]]
				whileTrue:[	index := x >> baseShift.
							spanBuffer at: index put: (spanBuffer at: index) + rampValue.
							x := x + 1.
							ds := ds + dsX.
							dt := dt + dtX].
			"Step to next ramp value"
			nextLength := self squaredLengthOf: ds //  16r10000 with: dt // 16r10000.
			[nextLength < length2] whileTrue:[
				rampIndex := rampIndex - 1.
				rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
				rampValue := (rampValue bitAnd: colorMask) >> colorShift.
				length2 := (rampIndex-1) * (rampIndex-1).
			].
		].
	].
	"Done -- store stuff back"
	(self cCoerce: deltaST to: 'int *') at: 0 put: ds.
	(self cCoerce: deltaST to: 'int *') at: 1 put: dt.
	^x