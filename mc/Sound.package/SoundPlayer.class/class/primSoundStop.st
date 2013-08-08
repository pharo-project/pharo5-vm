private
primSoundStop
	"Stop double-buffered sound output. Must not raise an error because it is used inside error handling and at system shutdown"

	<primitive: 'primitiveSoundStop' module: 'SoundPlugin'>