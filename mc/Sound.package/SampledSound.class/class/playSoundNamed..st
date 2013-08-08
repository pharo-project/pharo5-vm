sound library
playSoundNamed: aString
	"Play the sound with given name. Do nothing if there is no sound of that name in the library."
	"SampledSound playSoundNamed: 'croak'"

	| snd |
	snd := self soundNamed: aString.
	snd ifNotNil: [snd play].
	^ snd
