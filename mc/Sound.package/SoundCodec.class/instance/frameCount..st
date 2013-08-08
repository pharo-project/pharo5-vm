private
frameCount: aByteArray
	"Compute the frame count for this byteArray.  This default computation will have to be overridden by codecs with variable frame sizes."

	| codeFrameSize |
	codeFrameSize := self bytesPerEncodedFrame.
	(aByteArray size \\ codeFrameSize) = 0 ifFalse:
		[self error: 'encoded buffer is not an even multiple of the encoded frame size'].
	^ aByteArray size // codeFrameSize