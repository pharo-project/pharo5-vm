fills-gradient
fillRadialIncreasing: fill ramp: ramp deltaST: deltaST dsX: dsX dtX: dtX from: leftX to: rightX
	"Part 2b) Compute the increasing part of the ramp"
	| ds dt rampIndex rampValue length2 x x1 nextLength rampSize lastLength |
	<inline: true>
	ds := (self cCoerce: deltaST to:'int*') at: 0.
	dt := (self cCoerce: deltaST to:'int*') at: 1.
	rampIndex := self accurateLengthOf: ds // 16r10000 with: dt // 16r10000.
	rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
	rampSize := self gradientRampLengthOf: fill.
	length2 := (rampSize-1) * (rampSize-1). "This is the upper bound"
	nextLength := (rampIndex+1) * (rampIndex+1).
	lastLength := self squaredLengthOf: ds //  16r10000 with: dt // 16r10000.

	x := leftX.
	x1 := rightX.

	[x < x1 and:[lastLength < length2]] whileTrue:[
		"Try to copy the current value more than once"
		[x < x1 and:[(self squaredLengthOf: ds //  16r10000 with: dt // 16r10000) <= nextLength]]
			whileTrue:[	spanBuffer at: x put: rampValue.
						x := x + 1.
						ds := ds + dsX.
						dt := dt + dtX].
		lastLength := self squaredLengthOf: ds //  16r10000 with: dt // 16r10000.
		[lastLength > nextLength] whileTrue:[
			rampIndex := rampIndex + 1.
			rampValue := self makeUnsignedFrom: ((self cCoerce: ramp to:'int *') at: rampIndex).
			nextLength := (rampIndex+1) * (rampIndex+1).
		].
	].

	(self cCoerce: deltaST to: 'int *') at: 0 put: ds.
	(self cCoerce: deltaST to: 'int *') at: 1 put: dt.
	^x