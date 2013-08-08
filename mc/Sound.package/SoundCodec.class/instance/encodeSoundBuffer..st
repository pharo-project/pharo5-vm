private
encodeSoundBuffer: aSoundBuffer
	"Encode the entirety of the given monophonic SoundBuffer with this codec. Answer a ByteArray containing the compressed sound data."

	| codeFrameSize frameSize fullFrameCount lastFrameSamples result increments finalFrame i lastIncs |
	frameSize := self samplesPerFrame.
	fullFrameCount := aSoundBuffer monoSampleCount // frameSize.
	lastFrameSamples := aSoundBuffer monoSampleCount - (fullFrameCount * frameSize).
	codeFrameSize := self bytesPerEncodedFrame.
	codeFrameSize = 0 ifTrue:
		["Allow room for 1 byte per sample for variable-length compression"
		codeFrameSize := frameSize].
	lastFrameSamples > 0
		ifTrue: [result := ByteArray new: (fullFrameCount + 1) * codeFrameSize]
		ifFalse: [result := ByteArray new: fullFrameCount * codeFrameSize].
	self reset.
	increments := self encodeFrames: fullFrameCount from: aSoundBuffer at: 1 into: result at: 1.
	lastFrameSamples > 0 ifTrue: [
		finalFrame := SoundBuffer newMonoSampleCount: frameSize.
		i := fullFrameCount * frameSize.
		1 to: lastFrameSamples do: [:j |
			finalFrame at: j put: (aSoundBuffer at: (i := i + 1))].
		lastIncs := self encodeFrames: 1 from: finalFrame at: 1 into: result at: 1 + increments second.
		increments := Array with: increments first + lastIncs first
							with: increments second + lastIncs second].
	increments second < result size
		ifTrue: [^ result copyFrom: 1 to: increments second]
		ifFalse: [^ result]
