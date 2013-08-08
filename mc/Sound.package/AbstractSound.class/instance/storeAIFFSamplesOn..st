file i/o
storeAIFFSamplesOn: aBinaryStream
	"Store this sound as a 16-bit AIFF file at the current SoundPlayer sampling rate. Store both channels if self isStereo is true; otherwise, store the left channel only as a mono sound."

	| samplesToStore channelCount dataByteCount |
	samplesToStore := (self duration * self samplingRate) ceiling.
	channelCount := self isStereo ifTrue: [2] ifFalse: [1].
	dataByteCount := samplesToStore * channelCount * 2.

	"write AIFF file header:"
	aBinaryStream nextPutAll: 'FORM' asByteArray.
	aBinaryStream nextInt32Put: ((7 * 4) + 18) + dataByteCount.
	aBinaryStream nextPutAll: 'AIFF' asByteArray.
	aBinaryStream nextPutAll: 'COMM' asByteArray.
	aBinaryStream nextInt32Put: 18.
	aBinaryStream nextNumber: 2 put: channelCount.
	aBinaryStream nextInt32Put: samplesToStore.
	aBinaryStream nextNumber: 2 put: 16.  "bits/sample"
	self storeExtendedFloat: self samplingRate on: aBinaryStream.
	aBinaryStream nextPutAll: 'SSND' asByteArray.
	aBinaryStream nextInt32Put: dataByteCount + 8.
	aBinaryStream nextInt32Put: 0.
	aBinaryStream nextInt32Put: 0.

	"write data:"
	self storeSampleCount: samplesToStore bigEndian: true on: aBinaryStream.
