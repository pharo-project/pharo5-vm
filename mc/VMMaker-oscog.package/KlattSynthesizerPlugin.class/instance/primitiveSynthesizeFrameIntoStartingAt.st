primitives
primitiveSynthesizeFrameIntoStartingAt
	| aKlattFrame buffer startIndex rcvr bufferOop |
	<export: true>
	<var: 'aKlattFrame' type: 'float *'>
	<var: 'buffer' type: 'short *'>
	aKlattFrame := self checkedFloatPtrOf: (interpreterProxy stackValue: 2).
	buffer := self checkedShortPtrOf: (bufferOop := interpreterProxy stackValue: 1).
	startIndex := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue: [^nil].
	rcvr := interpreterProxy stackObjectValue: 3.
	(self loadFrom: rcvr) ifFalse:[^nil].
	interpreterProxy success: (interpreterProxy stSizeOf: bufferOop) * 2 >= samplesPerFrame.
	interpreterProxy failed ifTrue: [^nil].
	self synthesizeFrame: aKlattFrame into: buffer startingAt: startIndex.
	(self saveTo: rcvr) ifFalse: [^nil].
	interpreterProxy pop: 3