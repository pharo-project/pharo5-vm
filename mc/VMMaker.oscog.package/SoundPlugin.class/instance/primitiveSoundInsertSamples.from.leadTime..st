primitives
primitiveSoundInsertSamples: frameCount from: buf leadTime: leadTime 
	"Insert a buffer's worth of sound samples into the currently playing  
	buffer. Used to make a sound start playing as quickly as possible. The  
	new sound is mixed with the previously buffered sampled."
	"Details: Unlike primitiveSoundPlaySamples, this primitive always starts  
	with the first sample the given sample buffer. Its third argument  
	specifies the number of samples past the estimated sound output buffer  
	position the inserted sound should start. If successful, it returns the  
	number of samples inserted."
	| framesPlayed |
	self primitive: 'primitiveSoundInsertSamples'
		parameters: #(SmallInteger WordArray SmallInteger ).
	interpreterProxy success: frameCount <= (interpreterProxy slotSizeOf: buf cPtrAsOop).

	interpreterProxy failed
		ifFalse: [framesPlayed := self cCode: 'snd_InsertSamplesFromLeadTime(frameCount, (void *)buf, leadTime)'.
			interpreterProxy success: framesPlayed >= 0].
	^ framesPlayed asPositiveIntegerObj