instance creation
fromWaveStream: fileStream

	| stream header data type channels samplingRate blockAlign bitsPerSample leftAndRight |
	header := self readWaveChunk: 'fmt ' inRIFF: fileStream.
	data := self readWaveChunk: 'data' inRIFF: fileStream.
	fileStream close.
	stream := ReadStream on: header.
	type := self next16BitWord: false from: stream.
	type = 1 ifFalse: [^ self error:'Unexpected wave format'].
	channels := self next16BitWord: false from: stream.
	(channels < 1 or: [channels > 2])
		ifTrue: [^ self error: 'Unexpected number of wave channels'].
	samplingRate := self next32BitWord: false from: stream.
	stream skip: 4. "skip average bytes per second"
	blockAlign := self next16BitWord: false from: stream.
	bitsPerSample := self next16BitWord: false from: stream.
	(bitsPerSample = 8 or: [bitsPerSample = 16])
		ifFalse: [  "recompute bits per sample"
			bitsPerSample := (blockAlign // channels) * 8].

	bitsPerSample = 8
		ifTrue: [data := self convert8bitUnsignedTo16Bit: data]
		ifFalse: [data := self convertBytesTo16BitSamples: data mostSignificantByteFirst: false].

	channels = 2 ifTrue: [
		leftAndRight := data splitStereo.
		^ MixedSound new
			add: (self samples: leftAndRight first samplingRate: samplingRate) pan: 0.0;
			add: (self samples: leftAndRight last samplingRate: samplingRate) pan: 1.0;
			yourself].

	^ self samples: data samplingRate: samplingRate
