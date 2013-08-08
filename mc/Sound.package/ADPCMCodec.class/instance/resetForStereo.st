codec stuff
resetForStereo
	"Reset my encoding and decoding state for stereo."

	"keep state as SoundBuffers to allow fast access from primitive"
	predicted := SoundBuffer new: 2.
	index := SoundBuffer new: 2.
