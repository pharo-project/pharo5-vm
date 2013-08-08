subclass responsibilities
decodeFrames: frameCount from: srcByteArray at: srcIndex into: dstSoundBuffer at: dstIndex
	"Decode the given number of monophonic frames starting at the given index in the given ByteArray of compressed sound data and storing the decoded samples into the given SoundBuffer starting at the given destination index. Answer a pair containing the number of bytes of compressed data consumed and the number of decompressed samples produced."
	"Note: Assume that the sender has ensured that the given number of frames will not exhaust either the source or destination buffers."

	| frameBase coeffArray scale i c nullCount samples sourceFrameEnd frameSize inStream val |
	inStream := ReadStream on: srcByteArray from: srcIndex to: srcByteArray size.
	"frameCount := " inStream nextNumber: 4.
	samplesPerFrame := inStream nextNumber: 4.
	nLevels := inStream nextNumber: 4.
	alpha := Float fromIEEE32Bit: (inStream nextNumber: 4).
	beta := Float fromIEEE32Bit: (inStream nextNumber: 4).
	fwt ifNil:
		["NOTE: This should read parameters from the encoded data"
		fwt := FWT new.
		fwt nSamples: samplesPerFrame nLevels: nLevels.
		fwt setAlpha: alpha beta: beta].
	frameBase := dstIndex.
	coeffArray := fwt coeffs.  "A copy that we can modify"

	1 to: frameCount do:
		[:frame | 

		"Decode the scale for this frame"
		frameSize := inStream nextNumber: 2.
		sourceFrameEnd := frameSize + inStream position.
		scale := Float fromIEEE32Bit: (inStream nextNumber: 4).

		"Expand run-coded samples to scaled float values."
		i := 5.
		[i <= coeffArray size]
			whileTrue:
			[c := inStream next.
			c < 128
				ifTrue: [nullCount := c < 112
							ifTrue: [c + 1]
							ifFalse: [(c-112)*256 + inStream next + 1].
						i to: i + nullCount - 1 do: [:j | coeffArray at: j put: 0.0].
						i := i + nullCount]
				ifFalse: [val := (c*256 + inStream next) - 32768 - 16384.
						coeffArray at: i put: val * scale.
						i := i + 1]].

		"Copy float values into the wavelet sample array"		
			fwt coeffs: coeffArray.

		"Compute the transform"
		fwt transformForward: false.

		"Determine the scale for this frame"
		samples := fwt samples.
		samples size = samplesPerFrame ifFalse: [self error: 'frame size error'].
		1 to: samples size do:
			[:j | dstSoundBuffer at: frameBase + j - 1 put: (samples at: j) asInteger].

		inStream position = sourceFrameEnd ifFalse: [self error: 'frame size error'].
		frameBase := frameBase + samplesPerFrame].

	^ Array with: inStream position + 1 - srcIndex
			with: frameBase - dstIndex