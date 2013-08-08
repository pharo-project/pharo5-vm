private
primSoundStartBufferSize: bufferSize rate: samplesPerSecond stereo: stereoFlag
	"Start double-buffered sound output with the given buffer size and sampling rate. This version has been superceded by primitive 171 (primSoundStartBufferSize:rate:stereo:semaIndex:)."
	"ar 12/5/1998 Turn off the sound if not supported"
	<primitive: 'primitiveSoundStart' module: 'SoundPlugin'>
	SoundSupported := false.