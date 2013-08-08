private
primSoundGetVolume
	"Return sound as array of doubles left then right channel, range is 0.0 to 1.0 but may be overdriven"
	<primitive: 'primitiveSoundGetVolume' module: 'SoundPlugin'>
	^Array with: 1.0 with: 1.0