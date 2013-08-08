subclass responsibilities
encodeFrames: frameCount from: srcSoundBuffer at: srcIndex into: dstByteArray at: dstIndex
	"Encode the given number of frames starting at the given index in the given monophonic SoundBuffer and storing the encoded sound data into the given ByteArray starting at the given destination index. Encode only as many complete frames as will fit into the destination. Answer a pair containing the number of samples consumed and the number of bytes of compressed data produced."
	"Note: Assume that the sender has ensured that the given number of frames will not exhaust either the source or destination buffers."

	| frameBase coeffs maxVal minVal c scale nullCount frameI outFrameSize threshold sm outStream cMin val |
	threshold := 2000.
	fwt ifNil:
		[samplesPerFrame := self samplesPerFrame.
		nLevels := 8.
		"Here are some sample mother wavelets, with the compression achieved on a
		sample of my voice at a threshold of 2000:
									compression achieved "
		alpha := 0.0.  beta := 0.0.		"12.1"
		alpha := 1.72.  beta := 1.51.	"14.0"
		alpha := -1.86.  beta := -1.53.	"14.4"
		alpha := 1.28.  beta := -0.86.	"15.9"
		alpha := -1.15.  beta := 0.69.	"16.0"
		fwt := FWT new.
		fwt nSamples: samplesPerFrame nLevels: nLevels.
		fwt setAlpha: alpha beta: beta].

	(outStream := WriteStream on: dstByteArray from: dstIndex to: dstByteArray size)
		nextNumber: 4 put: frameCount;
		nextNumber: 4 put: samplesPerFrame;
		nextNumber: 4 put: nLevels;
		nextNumber: 4 put: alpha asIEEE32BitWord;
		nextNumber: 4 put: beta asIEEE32BitWord.
	frameBase := srcIndex.
	1 to: frameCount do:
		[:frame | 

		"Copy float values into the wavelet sample array"		
		fwt samples: ((frameBase to: frameBase + samplesPerFrame-1) 
				collect: [:i | (srcSoundBuffer at: i) asFloat]).

		"Compute the transform"
		fwt transformForward: true.

		frameI := outStream position+1.  "Reserve space for frame size"
		outStream nextNumber: 2 put: 0.

		"Determine and output the scale for this frame"
		coeffs := fwt coeffs.
		maxVal := 0.0.  minVal := 0.0.
		5 to: coeffs size do:
			[:i | c := coeffs at: i.
			c > maxVal ifTrue: [maxVal := c].
			c < minVal ifTrue: [minVal := c]].
		scale := (maxVal max: minVal negated) / 16000.0.  "Will scale all to -16k..16k: 15 bits"
		outStream nextNumber: 4 put: scale asIEEE32BitWord.

		"Copy scaled values, with run-coded sequences of 0's, to destByteArray"
		nullCount := 0.
		cMin := threshold / scale.
		5 to: coeffs size do:
			[:i | c := (coeffs at: i) / scale.
			c abs < cMin
			ifTrue: ["Below threshold -- count nulls."
					nullCount := nullCount + 1]
			ifFalse: ["Above threshold -- emit prior null count and this sample."
					nullCount > 0 ifTrue:
						[nullCount <= 112
						ifTrue: [outStream nextNumber: 1 put: nullCount-1]
						ifFalse: [outStream nextNumber: 2 put: (112*256) + nullCount-1].
						nullCount := 0].
						val := c asInteger + 16384 + 32768.  "Map -16k..16k into 32k..64k"
						outStream nextNumber: 2 put: val]].

					nullCount > 0 ifTrue:
						[nullCount <= 112
						ifTrue: [outStream nextNumber: 1 put: nullCount-1]
						ifFalse: [outStream nextNumber: 2 put: (112*256) + nullCount-1]].
		outFrameSize := outStream position+1 - frameI - 2.  "Write frame size back at the beginning"
		(WriteStream on: dstByteArray from: frameI to: dstByteArray size)
			nextNumber: 2 put: outFrameSize.
		frameBase := frameBase + samplesPerFrame].

"This displays a temporary indication of compression achieved"
sm := TextMorph new contents: (((frameBase - srcIndex) *2.0 / (outStream position+1 - dstIndex) truncateTo: 0.1) printString , ' : 1') asText allBold.
sm position: Sensor cursorPoint + (-20@30).
ActiveWorld addMorph: sm.
World doOneCycleNow.
sm delete.

	outStream position > dstByteArray size ifTrue:
		["The calling routine only provides buffer space for compression of 2:1 or better.  If you are just testing things, you can increase it to, eg, codeFrameSize := frameSize*3, which would be sufficient for a threshold of 0 (lossless conversion)."
		self error: 'Buffer overrun'].

	^ Array with: frameBase - srcIndex
			with: outStream position+1 - dstIndex