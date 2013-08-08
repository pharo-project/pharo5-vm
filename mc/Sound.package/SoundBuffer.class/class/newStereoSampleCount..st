instance creation
newStereoSampleCount: anInteger
	"Return a SoundBuffer large enough to hold the given number of stereo slices. A stereo 'slice' consists of two 16-bit samples, one for each channel."

	^ self basicNew: anInteger
