primitives
primitiveMPEG3AudioSamples: fileHandle stream: aNumber
	| file result |

	"long mpeg3_audio_samples(mpeg3_t *file, int stream)"
	<var: #file type: 'mpeg3_t * '>
	self primitive: 'primitiveMPEG3AudioSamples'
		parameters: #(Oop SmallInteger).

	file := self mpeg3tValueOf: fileHandle.
	file = nil ifTrue: [^0].
	aNumber < 0 ifTrue: [interpreterProxy success: false. ^nil].
	aNumber >= (self cCode: 'mpeg3_total_astreams(file)') ifTrue: [
		interpreterProxy success: false. ^0.
	].

	self cCode: 'result = mpeg3_audio_samples(file,aNumber)'.
	^result asOop: Float
