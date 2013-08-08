private
readChunk: chunkType size: chunkSize
	"Read a AIFF chunk of the given type. Skip unrecognized chunks. Leave the input stream positioned chunkSize bytes past its position when this method is called."

	chunkType = 'COMM' ifTrue: [^ self readCommonChunk: chunkSize].
	chunkType = 'SSND' ifTrue: [^ self readSamplesChunk: chunkSize].
	chunkType = 'INST' ifTrue: [^ self readInstrumentChunk: chunkSize].
	chunkType = 'MARK' ifTrue: [^ self readMarkerChunk: chunkSize].
	in skip: chunkSize.  "skip unknown chunks"
