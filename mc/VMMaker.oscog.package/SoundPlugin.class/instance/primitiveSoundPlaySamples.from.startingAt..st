primitives
primitiveSoundPlaySamples: frameCount from: buf startingAt: startIndex 
	"Output a buffer's worth of sound samples."
	| framesPlayed |
	self primitive: 'primitiveSoundPlaySamples'
		parameters: #(SmallInteger WordArray SmallInteger ).
	interpreterProxy success: (startIndex >= 1 and: [startIndex + frameCount - 1 <= (interpreterProxy slotSizeOf: buf cPtrAsOop)]).

	interpreterProxy failed
		ifFalse: [framesPlayed := self cCode: 'snd_PlaySamplesFromAtLength(frameCount, (void *)buf, startIndex - 1)'.
			interpreterProxy success: framesPlayed >= 0].
	^ framesPlayed asPositiveIntegerObj