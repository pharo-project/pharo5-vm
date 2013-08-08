file i/o
storeSunAudioSamplesOn: aBinaryStream
	"Store this sound as a 16-bit Sun audio file at the current SoundPlayer sampling rate. Store both channels if self isStereo is true; otherwise, store the left channel only as a mono sound."


	| samplesToStore channelCount dataByteCount |
	samplesToStore := (self duration * self samplingRate) ceiling.
	channelCount := self isStereo ifTrue: [2] ifFalse: [1].
	dataByteCount := samplesToStore * channelCount * 2.

	"write Sun audio file header"
	channelCount := self isStereo ifTrue: [2] ifFalse: [1].
	aBinaryStream nextPutAll: '.snd' asByteArray.
	aBinaryStream uint32: 24.	"header size in bytes"
	aBinaryStream uint32: dataByteCount.
	aBinaryStream uint32: 3.	"format: 16-bit linear"
	aBinaryStream uint32: self samplingRate truncated.
	aBinaryStream uint32: channelCount.

	"write data:"
	self storeSampleCount: samplesToStore bigEndian: true on: aBinaryStream.
