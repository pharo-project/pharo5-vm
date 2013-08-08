private
primSoundAvailableBytes
	"Return the number of bytes of available space in the sound output buffer."
	"Note: Squeak always uses buffers containing 4-bytes per sample (2 channels at 2 bytes per channel) regardless of the state of the Stereo flag."

	<primitive: 'primitiveSoundAvailableSpace' module: 'SoundPlugin'>
	^ self primitiveFailed
