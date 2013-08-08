examples
majorChordOn: aSound from: aPitch
	"FMSound majorChord play"

	| score majorScale leadingRest pan |
	majorScale := self majorPitchesFrom: aPitch.
	score := MixedSound new.
	leadingRest := pan := 0.
	#(1 3 5 8) do: [:noteIndex | | note |
		note := aSound
					soundForPitch: (majorScale at: noteIndex)
					dur: 2.0 - leadingRest
					loudness: 0.3.
		score add: (RestSound dur: leadingRest), note pan: pan.
		leadingRest := leadingRest + 0.2.
		pan := pan + 0.3].
	^ score
