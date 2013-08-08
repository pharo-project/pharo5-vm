examples-bach fugue
bachFugueOn: aSound
	"Play a fugue by J. S. Bach using the given sound as the sound for all four voices."
	"PluckedSound bachFugue play"

	^ MixedSound new
		add: (self bachFugueVoice1On: aSound) pan: 1.0;
		add: (self bachFugueVoice2On: aSound) pan: 0.0;
		add: (self bachFugueVoice3On: aSound) pan: 1.0;
		add: (self bachFugueVoice4On: aSound) pan: 0.0.
