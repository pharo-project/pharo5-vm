examples-bach fugue
stereoBachFugue
	"Play fugue by J. S. Bach in stereo using different timbres."
	"AbstractSound stereoBachFugue play"

	"(AbstractSound bachFugueVoice1On: FMSound flute1) play"
	"(AbstractSound bachFugueVoice1On: PluckedSound default) play"

	^ MixedSound new
		add: (self bachFugueVoice1On: FMSound oboe1) pan: 0.2;
		add: (self bachFugueVoice2On: FMSound organ1) pan: 0.8;
		add: (self bachFugueVoice3On: PluckedSound default) pan: 0.4;
		add: (self bachFugueVoice4On: FMSound brass1) pan: 0.6.
