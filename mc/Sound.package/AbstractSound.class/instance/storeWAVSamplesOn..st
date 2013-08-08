file i/o
storeWAVSamplesOn: aBinaryStream
	"Store this sound as a 16-bit Windows WAV file at the current SoundPlayer sampling rate. Store both channels if self isStereo is true; otherwise, store the left channel only as a mono sound."

	| samplesToStore channelCount dataByteCount samplesPerSec bytesPerSec |
	samplesToStore := (self duration * self samplingRate) ceiling.
	channelCount := self isStereo ifTrue: [2] ifFalse: [1].
	dataByteCount := samplesToStore * channelCount * 2.
	samplesPerSec := self samplingRate rounded.
	bytesPerSec := samplesPerSec * channelCount * 2.

	"file header"
	aBinaryStream
		nextPutAll: 'RIFF' asByteArray;
		nextLittleEndianNumber: 4 put: dataByteCount + 36;	"total length of all chunks"
		nextPutAll: 'WAVE' asByteArray.

	"format chunk"
	aBinaryStream
		nextPutAll: 'fmt ' asByteArray;
		nextLittleEndianNumber: 4 put: 16;	"length of this chunk"
		nextLittleEndianNumber: 2 put: 1;	"format tag"
		nextLittleEndianNumber: 2 put: channelCount;
		nextLittleEndianNumber: 4 put: samplesPerSec;
		nextLittleEndianNumber: 4 put: bytesPerSec;
		nextLittleEndianNumber: 2 put: 4;	"alignment"
		nextLittleEndianNumber: 2 put: 16.	"bits per sample"

	"data chunk"
	aBinaryStream
		nextPutAll: 'data' asByteArray;
		nextLittleEndianNumber: 4 put: dataByteCount.  "length of this chunk"

	self storeSampleCount: samplesToStore bigEndian: false on: aBinaryStream.
