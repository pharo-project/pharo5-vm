disk i/o
comeFullyUpOnReload: smartRefStream
	"Convert my sample buffers from ByteArrays into SampleBuffers after raw loading from a DataStream. Answer myself."

	leftSamples == rightSamples
		ifTrue: [
			leftSamples := SoundBuffer fromByteArray: self leftSamples.
			rightSamples := leftSamples]
		ifFalse: [
			leftSamples := SoundBuffer fromByteArray: self leftSamples.
			rightSamples := SoundBuffer fromByteArray: self rightSamples].

