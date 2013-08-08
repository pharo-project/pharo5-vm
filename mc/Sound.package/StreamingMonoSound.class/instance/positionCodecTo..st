private
positionCodecTo: desiredSampleIndex
	"Position to the closest frame before the given sample index when using a codec. If using the ADPCM codec, try to ensure that it is in sync with the compressed sample stream."

	| desiredFrameIndex desiredPosition tmpStream tmpCodec byteBuf bufFrames sampleBuf frameCount n startOffset |
	(codec isKindOf: ADPCMCodec) ifFalse: [
		"stateless codecs (or relatively stateless ones, like GSM: just jump to frame boundary"
		desiredFrameIndex := desiredSampleIndex // codec samplesPerFrame.
		stream position: audioDataStart + (desiredFrameIndex * codec bytesPerEncodedFrame).
		codec reset.
		^ self].

	"compute the desired stream position"
	desiredFrameIndex := desiredSampleIndex // codec samplesPerFrame.
	desiredPosition := audioDataStart + (desiredFrameIndex * codec bytesPerEncodedFrame).

	"copy stream and codec"
	(stream isKindOf: FileStream)
		ifTrue: [tmpStream := (FileStream readOnlyFileNamed: stream name) binary]
		ifFalse: [tmpStream := stream deepCopy].
	tmpCodec := codec copy reset.

	"reset the codec and start back about 30 seconds to try to get codec in sync"
	startOffset := ((desiredFrameIndex - 80000) max: 0) * codec bytesPerEncodedFrame.
	tmpStream position: audioDataStart + startOffset.

	"decode forward to the desired position"
	byteBuf := ByteArray new: (32000 roundTo: codec bytesPerEncodedFrame).
	bufFrames := byteBuf size // codec bytesPerEncodedFrame.
	sampleBuf := SoundBuffer newMonoSampleCount: bufFrames * codec samplesPerFrame.
	frameCount := (desiredPosition - tmpStream position) // codec bytesPerEncodedFrame.
	[frameCount > 0] whileTrue: [
		n := bufFrames min: frameCount.
		tmpStream next: n * codec bytesPerEncodedFrame into: byteBuf startingAt: 1.
		tmpCodec decodeFrames: n from: byteBuf at: 1 into: sampleBuf at: 1.
		frameCount := frameCount - n].

	codec := tmpCodec.
	stream position: tmpStream position.
	(tmpStream isKindOf: FileStream) ifTrue: [tmpStream close].