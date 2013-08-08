private
allocateBuffer
	"Allocate a new buffer and reset nextIndex."

	| bufferTime |
	bufferTime := stereo  "Buffer time = 1/2 second"
		ifTrue: [self samplingRate asInteger]
		ifFalse: [self samplingRate asInteger // 2].
	currentBuffer := SoundBuffer newMonoSampleCount:
		"Multiple of samplesPerFrame that is approx. bufferTime long"
		(bufferTime truncateTo: self samplesPerFrame).
	nextIndex := 1.
