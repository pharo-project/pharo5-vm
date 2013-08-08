instance creation
noteSequenceOn: aSound from: anArray
	"Build a note sequence (i.e., a SequentialSound) from the given array using the given sound as the instrument. Elements are either (pitch, duration, loudness) triples or (#rest duration) pairs.  Pitches can be given as names or as numbers."
	| score |
	score := SequentialSound new.
	anArray do: [:el | | pitch |
		el size = 3
			ifTrue: [
				pitch := el at: 1.
				pitch isNumber ifFalse: [pitch := self pitchForName: pitch].
				score add: (
					aSound
						soundForPitch: pitch
						dur: (el at: 2)
						loudness: (el at: 3) / 1000.0)]
			ifFalse: [
				score add: (RestSound dur: (el at: 2))]].
	^ score
