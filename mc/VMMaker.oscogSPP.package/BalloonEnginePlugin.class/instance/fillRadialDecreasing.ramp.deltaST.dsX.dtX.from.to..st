fills-gradient
fillRadialDecreasing: fill ramp: ramp deltaST: deltaST dsX: dsX dtX: dtX from: leftX to: rightX
	"Part 2a) Compute the decreasing part of the ramp"
	| ds dt rampIndex rampValue length2 x x1 nextLength |
	<inline: true>
	ds := (self cCoerce: deltaST to:'int*') at: 0.
	dt := (self cCoerce: deltaST to:'int*') at: 1.
	rampIndex := self accurateLengthOf: ds // 16r10000 with: dt // 16r10000.
	rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
	length2 := (rampIndex-1) * (rampIndex-1).

	x := leftX.
	x1 := rightX.
	x1 > (self fillOriginXOf: fill) ifTrue:[x1 := self fillOriginXOf: fill].
	[x < x1] whileTrue:[
		"Try to copy the current value more than just once"
		[x < x1 and:[(self squaredLengthOf: ds //  16r10000 with: dt // 16r10000) >= length2]]
			whileTrue:[	spanBuffer at: x put: rampValue.
						x := x + 1.
						ds := ds + dsX.
						dt := dt + dtX].
		"Step to next ramp value"
		nextLength := self squaredLengthOf: ds //  16r10000 with: dt // 16r10000.
		[nextLength < length2] whileTrue:[
			rampIndex := rampIndex - 1.
			rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
			length2 := (rampIndex-1) * (rampIndex-1).
		].
	].

	(self cCoerce: deltaST to: 'int *') at: 0 put: ds.
	(self cCoerce: deltaST to: 'int *') at: 1 put: dt.
	^x