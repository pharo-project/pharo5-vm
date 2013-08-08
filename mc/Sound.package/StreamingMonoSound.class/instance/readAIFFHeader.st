private
readAIFFHeader
	"Read an AIFF file header from stream."

	| aiffReader |
	aiffReader := AIFFFileReader new.
	aiffReader readFromStream: stream mergeIfStereo: false skipDataChunk: true.
	aiffReader channelCount = 1 ifFalse: [self error: 'not monophonic'].
	aiffReader bitsPerSample = 16 ifFalse: [self error: 'not 16-bit'].

	audioDataStart := headerStart + aiffReader channelDataOffset.
	streamSamplingRate := aiffReader samplingRate.
	totalSamples := aiffReader frameCount min: (stream size - audioDataStart) // 2.
	codec := nil.
