subclass responsibilities
encodeFrames: frameCount from: srcSoundBuffer at: srcIndex into: dstByteArray at: dstIndex

	| p |
	p := self	primEncode: encodeState frames: frameCount
			from: srcSoundBuffer at: srcIndex
			into: dstByteArray at: dstIndex.
	^ Array with: p x with: p y
