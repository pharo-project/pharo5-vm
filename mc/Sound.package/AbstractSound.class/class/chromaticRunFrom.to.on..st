examples
chromaticRunFrom: startPitch to: endPitch on: aSound
	"Answer a composite sound consisting of a rapid chromatic run between the given pitches on the given sound."
	"(AbstractSound chromaticRunFrom: 'c3' to: 'c#5' on: FMSound oboe1) play"

	| scale halfStep pEnd p |
	scale := SequentialSound new.
	halfStep := 2.0 raisedTo: (1.0 / 12.0).
	endPitch isNumber
		ifTrue: [pEnd := endPitch asFloat]
		ifFalse: [pEnd := AbstractSound pitchForName: endPitch].
	startPitch isNumber
		ifTrue: [p := startPitch asFloat]
		ifFalse: [p := AbstractSound pitchForName: startPitch].
	[p <= pEnd] whileTrue: [
		scale add: (aSound soundForPitch: p dur: 0.2 loudness: 0.5).
		p := p * halfStep].
	^ scale
