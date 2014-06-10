testing - MiscPrimitivePlugin
testConvert8bitSignedFromTo16Bit
	"SampledSound class>>convert8bitSignedFrom:to16Bit:"


	| aByteArray aSoundBuffer |
	aByteArray := #[1 2 3 4 5 6 7 8 9].
	aSoundBuffer := SoundBuffer newMonoSampleCount: aByteArray size.
	self convert8bitSignedFrom: aByteArray to16Bit: aSoundBuffer.
	self assert: aSoundBuffer = ((SoundBuffer new: 10) at: 1 put: 256; at: 2 put: 512;
		at: 3 put: 768; at: 4 put: 1024; at: 5 put: 1280; at: 6 put: 1536; at: 7 put: 1792;
		at: 8 put: 2048; at: 9 put: 2304; at: 10 put: 0; yourself)