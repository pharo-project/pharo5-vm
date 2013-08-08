subclass responsibilities
decodeFrames: frameCount from: srcByteArray at: srcIndex into: dstSoundBuffer at: dstIndex

	| p |
	p := self	primDecode: decodeState frames: frameCount
			from: srcByteArray at: srcIndex
			into: dstSoundBuffer at: dstIndex.
	^ Array with: p x with: p y
