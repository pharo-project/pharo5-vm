other
writeHeaderSamplingRate: samplingRate format: audioFormat
	"Write a Sun audio file header for the given sampling rate and format. Currently, only monophonic files are supported."

	self ensureOpen.
	stream position: headerStart.
	stream nextPutAll: '.snd' asByteArray.
	stream uint32: 24.	"header size in bytes"
	stream uint32: 0.	"sample data size in bytes; fill in later"
	stream uint32: audioFormat.
	stream uint32: samplingRate truncated.
	stream uint32: 1.	"channel count"
