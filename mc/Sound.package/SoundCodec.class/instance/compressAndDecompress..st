compress/decompress
compressAndDecompress: aSound
	"Compress and decompress the given sound. Useful for testing."
	"(MuLawCodec new compressAndDecompress: (SampledSound soundNamed: 'camera')) play"

	^ (self compressSound: aSound) asSound
