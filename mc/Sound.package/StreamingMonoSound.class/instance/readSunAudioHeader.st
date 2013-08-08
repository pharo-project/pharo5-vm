private
readSunAudioHeader
	"Read a Sun audio file header from my stream."

	| id headerBytes dataBytes format channelCount |
	id := (stream next: 4) asString.
	headerBytes := stream uint32.  "header bytes"
	dataBytes := stream uint32.
	format := stream uint32.
	streamSamplingRate := stream uint32.
	channelCount := stream uint32.

	id = '.snd' ifFalse: [self error: 'not Sun audio format'].
	dataBytes := dataBytes min: (stream size - headerBytes).
	channelCount = 1 ifFalse: [self error: 'not monophonic'].
	audioDataStart := headerStart + headerBytes.
	codec := nil.
	format = 1 ifTrue: [  "8-bit u-LAW"
		codec := MuLawCodec new.
		totalSamples := dataBytes.
		^ self].
	format = 3 ifTrue: [  "16-bit linear"
		totalSamples := dataBytes // 2.
		^ self].
	format = 23 ifTrue: [  "ADPCM-4 bit (CCITT G.721)"
		codec := ADPCMCodec new
			initializeForBitsPerSample: 4 samplesPerFrame: 0.
		totalSamples := (dataBytes // 4) * 8.
		^ self].
	format = 25 ifTrue: [  "ADPCM-3 bit (CCITT G.723)"
		codec := ADPCMCodec new
			initializeForBitsPerSample: 3 samplesPerFrame: 0.
		totalSamples := (dataBytes // 3) * 8.
		^ self].
	format = 26 ifTrue: [  "ADPCM-5 bit (CCITT G.723)"
		codec := ADPCMCodec new
			initializeForBitsPerSample: 5 samplesPerFrame: 0.
		totalSamples := (dataBytes // 5) * 8.
		^ self].
	format = 610 ifTrue: [  "GSM 06.10 (this format was added by Squeak)"
		codec := GSMCodec new.
		totalSamples := (dataBytes // 33) * 160.
		^ self].
	self error: 'unsupported Sun audio format ', format printString
