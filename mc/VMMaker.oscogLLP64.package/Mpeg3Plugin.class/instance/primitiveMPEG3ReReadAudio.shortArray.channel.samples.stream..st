primitives
primitiveMPEG3ReReadAudio: fileHandle shortArray: anArray channel: aChannelNumber samples: aSampleNumber stream: aNumber
	| file result arrayBase |

	"int mpeg3_reread_audio(mpeg3_t *file, 
		float *output_f, 
		short *output_i, 
		int channel, 
		long samples,
		int stream)"
	<var: #file type: 'mpeg3_t * '>
	<var: #arrayBase type: 'short * '>
	self primitive: 'primitiveMPEG3ReReadAudio'
		parameters: #(Oop Array SmallInteger SmallInteger SmallInteger).

	file := self mpeg3tValueOf: fileHandle.
	file = nil ifTrue: [^0].
	aNumber < 0 ifTrue: [interpreterProxy success: false. ^nil].
	aNumber >= (self cCode: 'result = mpeg3_total_astreams(file)') ifTrue: [
		interpreterProxy success: false.  ^0 ].


	arrayBase := self cCoerce: anArray to: 'short *'.
	interpreterProxy failed ifTrue: [^nil].
	self cCode: 'result = mpeg3_reread_audio(file,(float *) NULL,arrayBase,aChannelNumber,aSampleNumber,aNumber)'.
	^result asSmallIntegerObj
